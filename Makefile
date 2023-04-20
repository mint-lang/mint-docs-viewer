default:
	mint build --skip-service-worker && \
	rm -rf ../mint/src/assets/docs-viewer && \
	mv dist ../mint/src/assets/docs-viewer
