# TTS generator (gTTS)
# scripts/tts_generate.py
# Requires: pip install gTTS
from gtts import gTTS
text = "新品上市，柔润呵护。瞬吸不渗，细腻柔软。安心陪伴每一餐。扫码立即购买，立即体验！"
tts = gTTS(text, lang='zh-cn', slow=False)
tts.save("voice.mp3")
print("Saved voice.mp3")
