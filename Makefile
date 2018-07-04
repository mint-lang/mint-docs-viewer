default:
	mint build && \
	rm -rf ../mint/src/assets/docs-viewer && \
	mv dist ../mint/src/assets/docs-viewer
