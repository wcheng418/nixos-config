self: super: {
  tensorflow = super.tensorflow.override {
    cudaSupport = true;
  };
}
