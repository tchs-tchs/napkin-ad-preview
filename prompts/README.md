# Photography-grade AI prompts for 10s Napkin Ad

本目录包含用于生成「餐巾纸 10s 广告」的高质量摄影级 prompts（Stable Diffusion / Automatic1111 (SDXL)、Midjourney、Runway），以及后续合成成片的自动化脚本。

使用说明（快速流程）
1. 在你选择的生成服务上按 prompts 生成 4 张竖屏图（1080×1920），命名为：img1.png、img2.png、img3.png、img4.png。每张对应时长：2.5s / 3.0s / 3.0s / 1.5s。
2. 把四张图片放到仓库根目录或 scripts 里指定的目录。
3. 准备背景音乐 music.mp3（可选）和/或配音 voice.mp3（可选）。若无配音，脚本会用 gTTS 生成简短旁白。
4. 运行脚本 scripts/make_video.sh（Linux/macOS）或在 Windows 上用 WSL。脚本会产出 final_video.mp4。

如果你希望我代为调用某个在线渲染 API 并生成图片，请明确告诉我你要用的服务与是否愿意提供 API key；我会给出安全的执行方式或代为运行（需你授权）。
