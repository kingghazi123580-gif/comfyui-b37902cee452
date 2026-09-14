# clean base image containing only comfyui, comfy-cli and comfyui-manager
FROM runpod/worker-comfyui:5.10.0-base

# build-time tokens for gated downloads — never baked into final image.
# pass via: docker build --build-arg HF_TOKEN=$HF_TOKEN ...
ARG HF_TOKEN=""

# download models into comfyui
RUN BACKOFFS="10 20 30 60 90" && for i in 1 2 3 4 5; do HF_TOKEN=$HF_TOKEN comfy model download --url 'https://huggingface.co/Lightricks/LTX-2.5/resolve/main/diffusion_models/ltx-2.5-22b-distilled-transformer-comfy-int8-convrot.safetensors' --relative-path models/diffusion_models --filename 'ltx-2.5-22b-distilled-transformer-comfy-int8-convrot.safetensors' && break; if [ $i -eq 5 ]; then echo "model-download failed after 5 attempts" >&2; exit 1; fi; SLEEP=$(echo $BACKOFFS | cut -d ' ' -f $i) && echo "model-download attempt $i failed; retrying in $SLEEP seconds" >&2; sleep $SLEEP; done
RUN BACKOFFS="10 20 30 60 90" && for i in 1 2 3 4 5; do HF_TOKEN=$HF_TOKEN comfy model download --url 'https://huggingface.co/Lightricks/LTX-2.5/resolve/main/vae/ltx-2.5-video-vae-bf16.safetensors' --relative-path models/vae --filename 'ltx-2.5-video-vae-bf16.safetensors' && break; if [ $i -eq 5 ]; then echo "model-download failed after 5 attempts" >&2; exit 1; fi; SLEEP=$(echo $BACKOFFS | cut -d ' ' -f $i) && echo "model-download attempt $i failed; retrying in $SLEEP seconds" >&2; sleep $SLEEP; done
RUN BACKOFFS="10 20 30 60 90" && for i in 1 2 3 4 5; do HF_TOKEN=$HF_TOKEN comfy model download --url 'https://huggingface.co/Lightricks/LTX-2.5/resolve/main/vae/ltx-2.5-audio-vae-bf16.safetensors' --relative-path models/vae --filename 'ltx-2.5-audio-vae-bf16.safetensors' && break; if [ $i -eq 5 ]; then echo "model-download failed after 5 attempts" >&2; exit 1; fi; SLEEP=$(echo $BACKOFFS | cut -d ' ' -f $i) && echo "model-download attempt $i failed; retrying in $SLEEP seconds" >&2; sleep $SLEEP; done
RUN BACKOFFS="10 20 30 60 90" && for i in 1 2 3 4 5; do HF_TOKEN=$HF_TOKEN comfy model download --url 'https://huggingface.co/Lightricks/LTX-2.5/resolve/main/text_encoders/gemma4-12b-with-proj-ltx-2.5-comfy-int8-convrot.safetensors' --relative-path models/text_encoders --filename 'gemma4-12b-with-proj-ltx-2.5-comfy-int8-convrot.safetensors' && break; if [ $i -eq 5 ]; then echo "model-download failed after 5 attempts" >&2; exit 1; fi; SLEEP=$(echo $BACKOFFS | cut -d ' ' -f $i) && echo "model-download attempt $i failed; retrying in $SLEEP seconds" >&2; sleep $SLEEP; done
RUN BACKOFFS="10 20 30 60 90" && for i in 1 2 3 4 5; do HF_TOKEN=$HF_TOKEN comfy model download --url 'https://huggingface.co/Lightricks/LTX-2.5/resolve/main/latent_upscale_models/ltx-2.5-latent-spatial-upscaler-x2-bf16-1.0.safetensors' --relative-path models/latent_upscale_models --filename 'ltx-2.5-latent-spatial-upscaler-x2-bf16-1.0.safetensors' && break; if [ $i -eq 5 ]; then echo "model-download failed after 5 attempts" >&2; exit 1; fi; SLEEP=$(echo $BACKOFFS | cut -d ' ' -f $i) && echo "model-download attempt $i failed; retrying in $SLEEP seconds" >&2; sleep $SLEEP; done
RUN BACKOFFS="10 20 30 60 90" && for i in 1 2 3 4 5; do HF_TOKEN=$HF_TOKEN comfy model download --url 'https://huggingface.co/Comfy-Org/gemma-4/resolve/main/text_encoders/gemma4_e2b_it_bf16.safetensors' --relative-path models/text_encoders --filename 'gemma4_e2b_it_bf16.safetensors' && break; if [ $i -eq 5 ]; then echo "model-download failed after 5 attempts" >&2; exit 1; fi; SLEEP=$(echo $BACKOFFS | cut -d ' ' -f $i) && echo "model-download attempt $i failed; retrying in $SLEEP seconds" >&2; sleep $SLEEP; done

# copy all input data (like images or videos) into comfyui (uncomment and adjust if needed)
# COPY input/ /comfyui/input/

# user-provided inputs override the auto-generated placeholders above.
RUN wget --progress=dot:giga -O '/comfyui/input/neon_cyborg_portrait.png' "https://cool-anteater-319.convex.cloud/api/storage/c1893727-9cbc-4255-8776-e4d5a30b8e36"
