对接说明与后续如果需要我代为生成图像

- 如果你希望我代替生成四张摄影级图像，我可以在你授权下调用第三方渲染 API（例如 Replicate / Stability / Runway / Midjourney）。调用前我会把要用到的 prompts 与运行参数发给你确认，并且只在得到你的 API key 与明确授权后才会执行。

- 若你愿意让我代为生成，请回复：
  1) 你想用的服务（选择一项：StableDiffusion(Auto1111/SDXL), Midjourney, Runway, Replicate）
  2) 你是否愿意把对应服务的 API key 发给我（注意安全性、我会给出一次性安全上传方法或让你在本地执行脚本并返回生成结果）

或者，如果你不想提供密钥，我会把上面 prompts 交给你，你在本地或你自己的服务上生成并把四张图上传回此仓库；我会在你上传后自动运行 scripts/make_video.sh（或指导你运行）并产出 final_video.mp4。
