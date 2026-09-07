#!/usr/bin/env bash
# scripts/make_video.sh
# 用法: 把生成的 img1.png img2.png img3.png img4.png 放在同目录，准备 music.mp3（可选）。
# 运行: bash scripts/make_video.sh

set -e
ROOT_DIR=$(cd "$(dirname "$0")/.." && pwd)
cd "$ROOT_DIR"

# 1. 检查图片
for i in 1 2 3 4; do
  if [ ! -f img${i}.png ]; then
    echo "Missing img${i}.png - please generate and place in repo root."
    exit 1
  fi
done

# durations
d1=2.5
d2=3.0
d3=3.0
d4=1.5

# make clips
ffmpeg -y -loop 1 -i img1.png -c:v libx264 -t ${d1} -pix_fmt yuv420p -vf "scale=1080:1920,format=yuv420p" v1.mp4
ffmpeg -y -loop 1 -i img2.png -c:v libx264 -t ${d2} -pix_fmt yuv420p -vf "scale=1080:1920,format=yuv420p" v2.mp4
ffmpeg -y -loop 1 -i img3.png -c:v libx264 -t ${d3} -pix_fmt yuv420p -vf "scale=1080:1920,format=yuv420p" v3.mp4
ffmpeg -y -loop 1 -i img4.png -c:v libx264 -t ${d4} -pix_fmt yuv420p -vf "scale=1080:1920,format=yuv420p" v4.mp4

# concat with crossfade (simple approach: concat hard cut for reliability)
printf "file 'v1.mp4'\nfile 'v2.mp4'\nfile 'v3.mp4'\nfile 'v4.mp4'\n" > list.txt
ffmpeg -y -f concat -safe 0 -i list.txt -c copy temp_video.mp4

# audio: if voice.mp3 missing, generate with gTTS
if [ ! -f voice.mp3 ]; then
  if command -v python3 >/dev/null 2>&1; then
    echo "Generating voice.mp3 with gTTS..."
    python3 scripts/tts_generate.py
  else
    echo "python3 not found - skipping TTS (you can add voice.mp3 manually)."
  fi
fi

# mix audio: prefer voice + music if exists
if [ -f music.mp3 ] && [ -f voice.mp3 ]; then
  ffmpeg -y -i temp_video.mp4 -i music.mp3 -i voice.mp3 -filter_complex "[1:a]volume=0.3[a1];[2:a]volume=1.0[a2];[a1][a2]amix=inputs=2:duration=shortest:dropout_transition=2[aout]" -map 0:v -map "[aout]" -c:v copy -c:a aac -shortest combined.mp4
elif [ -f voice.mp3 ]; then
  ffmpeg -y -i temp_video.mp4 -i voice.mp3 -map 0:v -map 1:a -c:v copy -c:a aac -shortest combined.mp4
elif [ -f music.mp3 ]; then
  ffmpeg -y -i temp_video.mp4 -i music.mp3 -map 0:v -map 1:a -c:v copy -c:a aac -shortest combined.mp4
else
  # no audio
  cp temp_video.mp4 combined.mp4
fi

# overlay subtitle and small logo (if logo_small.png exists)
if [ -f logo_small.png ]; then
  ffmpeg -y -i combined.mp4 -i logo_small.png -vf "subtitles=subtitle.srt:force_style='FontName=Arial,FontSize=48,PrimaryColour=&H00FFFFFF',overlay=W-w-40:H-h-40" -c:a copy final_video.mp4
else
  ffmpeg -y -i combined.mp4 -vf "subtitles=subtitle.srt:force_style='FontName=Arial,FontSize=48,PrimaryColour=&H00FFFFFF'" -c:a copy final_video.mp4
fi

echo "final_video.mp4 created in $(pwd)"
