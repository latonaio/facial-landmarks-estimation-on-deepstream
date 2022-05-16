# facial-landmarks-estimator-on-deepstream
facial-landmarks-estimator-on-deepstream は、DeepStream 上で FacialLandmarksEstimation の AIモデル を動作させるマイクロサービスです。  

## 動作環境
- NVIDIA 
    - DeepStream
- FacialLandmarksEstimation
- Docker
- TensorRT Runtime

## FacialLandmarksEstimationについて
FacialLandmarksEstimation は、画像内の顔の主なランドマークを検出し、顔の形状予測を行うAIモデルです。

## 動作手順
### Dockerコンテナの起動
Makefile に記載された以下のコマンドにより、FacialLandmarksEstimation の Dockerコンテナ を起動します。
```
docker-run: ## docker container の立ち上げ
	docker-compose up -d
```
### ストリーミングの開始
Makefile に記載された以下のコマンドにより、DeepStream 上の FacialLandmarksEstimation でストリーミングを開始します。  
```
stream-start: ## ストリーミングを開始する
	xhost +
	docker exec -it faciallandmarks-camera cp /app/mnt/deepstream-faciallandmark-app /app/src/deepstream_tao_apps/apps/tao_others/deepstream-faciallandmark-app/
	docker exec -it faciallandmarks-camera cp /app/mnt/facedetect.engine /app/src/deepstream_tao_apps/models/faciallandmark/facenet.etlt_b1_gpu0_fp16.engine
	docker exec -it faciallandmarks-camera cp /app/mnt/faciallandmarks.engine /app/src/deepstream_tao_apps/models/faciallandmark/faciallandmarks.etlt_b32_gpu0_fp16.engine
	docker exec -it faciallandmarks-camera cp /app/mnt/config_infer_primary_facedetect.txt /app/src/deepstream_tao_apps/configs/facial_tao/config_infer_primary_facenet.txt
	docker exec -it faciallandmarks-camera cp /app/mnt/faciallandmark_sgie_config.txt /app/src/deepstream_tao_apps/configs/facial_tao/faciallandmark_sgie_config.txt
	docker exec -it -w /app/src/deepstream_tao_apps/apps/tao_others/deepstream-faciallandmark-app faciallandmarks-camera \
		./deepstream-faciallandmark-app 3 /app/src/deepstream_tao_apps/configs/facial_tao/sample_faciallandmarks_config.txt /dev/video0 landmarks

```
## 相互依存関係にあるマイクロサービス  
本マイクロサービスを実行するために FacialLandmarksEstimation の AIモデルを最適化する手順は、[facial-landmarks-estimator-on-tao-toolkit](https://github.com/latonaio/facial-landmarks-estimator-on-tao-toolkit)を参照してください。  


## engineファイルについて
engineファイルである faciallandmarks.engine は、[facial-landmarks-estimator-on-tao-toolkit](https://github.com/latonaio/facial-landmarks-estimator-on-tao-toolkit)と共通のファイルであり、当該レポジトリで作成した engineファイルを、本リポジトリで使用しています。  
