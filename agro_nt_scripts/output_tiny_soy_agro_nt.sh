RUNNING SCRIPT
WARNING:root:Perform single sequence classification...
WARNING:root:Perform single sequence classification...
WARNING:root:Perform single sequence classification...
Some weights of EsmForSequenceClassification were not initialized from the model checkpoint at /ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/dnabert/agro-nucleotide-transformer-1b and are newly initialized: ['classifier.dense.bias', 'classifier.dense.weight', 'classifier.out_proj.bias', 'classifier.out_proj.weight']
You should probably TRAIN this model on a down-stream task to be able to use it for predictions and inference.
/hpc-home/mahony/.local/lib/python3.12/site-packages/accelerate/accelerator.py:436: FutureWarning: Passing the following arguments to `Accelerator` is deprecated and will be removed in version 1.0 of Accelerate: dict_keys(['dispatch_batches', 'split_batches', 'even_batches', 'use_seedable_sampler']). Please pass an `accelerate.DataLoaderConfiguration` instead: 
dataloader_config = DataLoaderConfiguration(dispatch_batches=None, split_batches=False, even_batches=True, use_seedable_sampler=True)
  warnings.warn(
Using auto half precision backend
***** Running training *****
  Num examples = 26,803
  Num Epochs = 2
  Instantaneous batch size per device = 1
  Total train batch size (w. parallel, distributed & accumulation) = 32
  Gradient Accumulation steps = 32
  Total optimization steps = 1,674
  Number of trainable parameters = 985,098,102
  0%|          | 0/1674 [00:00<?, ?it/s]/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [66,0,0], thread: [96,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [66,0,0], thread: [97,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [66,0,0], thread: [98,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [66,0,0], thread: [99,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [66,0,0], thread: [100,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [66,0,0], thread: [101,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [66,0,0], thread: [102,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [66,0,0], thread: [103,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [66,0,0], thread: [104,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [66,0,0], thread: [105,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [66,0,0], thread: [106,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [66,0,0], thread: [107,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [66,0,0], thread: [108,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [66,0,0], thread: [109,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [66,0,0], thread: [110,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [66,0,0], thread: [111,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [66,0,0], thread: [112,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [66,0,0], thread: [113,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [66,0,0], thread: [114,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [66,0,0], thread: [115,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [66,0,0], thread: [116,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [66,0,0], thread: [117,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [66,0,0], thread: [118,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [66,0,0], thread: [119,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [66,0,0], thread: [120,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [66,0,0], thread: [121,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [66,0,0], thread: [122,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [66,0,0], thread: [123,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [66,0,0], thread: [124,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [66,0,0], thread: [125,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [66,0,0], thread: [126,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [66,0,0], thread: [127,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [66,0,0], thread: [0,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [66,0,0], thread: [1,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [66,0,0], thread: [2,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [66,0,0], thread: [3,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [66,0,0], thread: [4,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [66,0,0], thread: [5,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [66,0,0], thread: [6,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [66,0,0], thread: [7,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [66,0,0], thread: [8,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [66,0,0], thread: [9,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [66,0,0], thread: [10,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [66,0,0], thread: [11,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [66,0,0], thread: [12,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [66,0,0], thread: [13,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [66,0,0], thread: [14,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [66,0,0], thread: [15,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [66,0,0], thread: [16,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [66,0,0], thread: [17,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [66,0,0], thread: [18,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [66,0,0], thread: [19,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [66,0,0], thread: [20,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [66,0,0], thread: [21,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [66,0,0], thread: [22,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [66,0,0], thread: [23,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [66,0,0], thread: [24,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [66,0,0], thread: [25,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [66,0,0], thread: [26,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [66,0,0], thread: [27,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [66,0,0], thread: [28,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [66,0,0], thread: [29,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [66,0,0], thread: [30,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [66,0,0], thread: [31,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [174,0,0], thread: [32,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [174,0,0], thread: [33,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [174,0,0], thread: [34,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [174,0,0], thread: [35,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [174,0,0], thread: [36,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [174,0,0], thread: [37,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [174,0,0], thread: [38,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [174,0,0], thread: [39,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [174,0,0], thread: [40,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [174,0,0], thread: [41,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [174,0,0], thread: [42,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [174,0,0], thread: [43,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [174,0,0], thread: [44,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [174,0,0], thread: [45,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [174,0,0], thread: [46,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [174,0,0], thread: [47,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [174,0,0], thread: [48,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [174,0,0], thread: [49,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [174,0,0], thread: [50,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [174,0,0], thread: [51,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [174,0,0], thread: [52,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [174,0,0], thread: [53,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [174,0,0], thread: [54,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [174,0,0], thread: [55,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [174,0,0], thread: [56,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [174,0,0], thread: [57,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [174,0,0], thread: [58,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [174,0,0], thread: [59,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [174,0,0], thread: [60,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [174,0,0], thread: [61,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [174,0,0], thread: [62,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [174,0,0], thread: [63,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [174,0,0], thread: [64,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [174,0,0], thread: [65,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [174,0,0], thread: [66,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [174,0,0], thread: [67,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [174,0,0], thread: [68,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [174,0,0], thread: [69,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [174,0,0], thread: [70,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [174,0,0], thread: [71,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [174,0,0], thread: [72,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [174,0,0], thread: [73,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [174,0,0], thread: [74,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [174,0,0], thread: [75,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [174,0,0], thread: [76,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [174,0,0], thread: [77,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [174,0,0], thread: [78,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [174,0,0], thread: [79,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [174,0,0], thread: [80,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [174,0,0], thread: [81,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [174,0,0], thread: [82,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [174,0,0], thread: [83,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [174,0,0], thread: [84,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [174,0,0], thread: [85,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [174,0,0], thread: [86,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [174,0,0], thread: [87,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [174,0,0], thread: [88,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [174,0,0], thread: [89,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [174,0,0], thread: [90,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [174,0,0], thread: [91,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [174,0,0], thread: [92,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [174,0,0], thread: [93,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [174,0,0], thread: [94,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [174,0,0], thread: [95,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [118,0,0], thread: [32,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [118,0,0], thread: [33,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [118,0,0], thread: [34,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [118,0,0], thread: [35,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [118,0,0], thread: [36,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [118,0,0], thread: [37,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [118,0,0], thread: [38,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [118,0,0], thread: [39,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [118,0,0], thread: [40,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [118,0,0], thread: [41,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [118,0,0], thread: [42,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [118,0,0], thread: [43,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [118,0,0], thread: [44,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [118,0,0], thread: [45,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [118,0,0], thread: [46,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [118,0,0], thread: [47,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [118,0,0], thread: [48,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [118,0,0], thread: [49,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [118,0,0], thread: [50,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [118,0,0], thread: [51,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [118,0,0], thread: [52,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [118,0,0], thread: [53,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [118,0,0], thread: [54,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [118,0,0], thread: [55,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [118,0,0], thread: [56,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [118,0,0], thread: [57,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [118,0,0], thread: [58,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [118,0,0], thread: [59,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [118,0,0], thread: [60,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [118,0,0], thread: [61,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [118,0,0], thread: [62,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [118,0,0], thread: [63,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [32,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [33,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [34,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [35,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [36,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [37,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [38,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [39,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [40,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [41,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [42,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [43,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [44,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [45,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [46,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [47,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [48,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [49,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [50,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [51,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [52,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [53,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [54,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [55,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [56,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [57,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [58,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [59,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [60,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [61,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [62,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [63,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [64,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [65,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [66,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [67,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [68,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [69,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [70,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [71,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [72,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [73,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [74,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [75,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [76,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [77,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [78,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [79,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [80,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [81,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [82,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [83,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [84,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [85,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [86,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [87,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [88,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [89,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [90,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [91,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [92,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [93,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [94,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [95,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [96,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [97,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [98,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [99,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [100,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [101,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [102,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [103,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [104,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [105,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [106,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [107,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [108,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [109,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [110,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [111,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [112,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [113,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [114,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [115,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [116,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [117,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [118,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [119,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [120,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [121,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [122,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [123,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [124,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [125,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [126,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [94,0,0], thread: [127,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [96,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [97,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [98,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [99,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [100,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [101,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [102,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [103,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [104,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [105,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [106,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [107,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [108,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [109,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [110,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [111,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [112,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [113,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [114,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [115,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [116,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [117,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [118,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [119,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [120,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [121,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [122,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [123,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [124,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [125,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [126,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [127,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [0,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [1,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [2,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [3,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [4,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [5,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [6,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [7,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [8,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [9,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [10,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [11,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [12,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [13,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [14,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [15,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [16,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [17,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [18,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [19,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [20,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [21,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [22,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [23,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [24,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [25,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [26,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [27,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [28,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [29,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [30,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [31,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [64,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [65,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [66,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [67,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [68,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [69,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [70,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [71,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [72,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [73,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [74,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [75,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [76,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [77,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [78,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [79,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [80,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [81,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [82,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [83,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [84,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [85,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [86,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [87,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [88,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [89,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [90,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [91,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [92,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [93,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [94,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [95,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [32,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [33,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [34,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [35,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [36,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [37,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [38,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [39,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [40,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [41,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [42,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [43,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [44,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [45,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [46,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [47,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [48,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [49,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [50,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [51,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [52,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [53,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [54,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [55,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [56,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [57,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [58,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [59,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [60,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [61,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [62,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [82,0,0], thread: [63,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [64,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [65,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [66,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [67,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [68,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [69,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [70,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [71,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [72,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [73,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [74,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [75,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [76,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [77,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [78,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [79,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [80,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [81,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [82,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [83,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [84,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [85,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [86,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [87,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [88,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [89,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [90,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [91,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [92,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [93,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [94,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [95,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [32,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [33,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [34,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [35,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [36,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [37,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [38,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [39,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [40,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [41,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [42,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [43,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [44,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [45,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [46,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [47,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [48,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [49,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [50,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [51,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [52,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [53,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [54,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [55,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [56,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [57,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [58,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [59,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [60,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [61,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [62,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [63,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [0,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [1,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [2,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [3,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [4,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [5,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [6,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [7,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [8,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [9,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [10,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [11,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [12,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [13,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [14,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [15,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [16,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [17,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [18,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [19,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [20,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [21,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [22,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [23,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [24,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [25,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [26,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [27,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [28,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [29,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [30,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [31,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [96,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [97,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [98,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [99,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [100,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [101,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [102,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [103,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [104,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [105,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [106,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [107,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [108,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [109,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [110,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [111,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [112,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [113,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [114,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [115,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [116,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [117,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [118,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [119,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [120,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [121,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [122,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [123,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [124,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [125,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [126,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [83,0,0], thread: [127,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [26,0,0], thread: [0,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [26,0,0], thread: [1,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [26,0,0], thread: [2,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [26,0,0], thread: [3,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [26,0,0], thread: [4,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [26,0,0], thread: [5,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [26,0,0], thread: [6,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [26,0,0], thread: [7,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [26,0,0], thread: [8,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [26,0,0], thread: [9,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [26,0,0], thread: [10,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [26,0,0], thread: [11,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [26,0,0], thread: [12,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [26,0,0], thread: [13,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [26,0,0], thread: [14,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [26,0,0], thread: [15,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [26,0,0], thread: [16,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [26,0,0], thread: [17,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [26,0,0], thread: [18,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [26,0,0], thread: [19,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [26,0,0], thread: [20,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [26,0,0], thread: [21,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [26,0,0], thread: [22,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [26,0,0], thread: [23,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [26,0,0], thread: [24,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [26,0,0], thread: [25,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [26,0,0], thread: [26,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [26,0,0], thread: [27,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [26,0,0], thread: [28,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [26,0,0], thread: [29,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [26,0,0], thread: [30,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [26,0,0], thread: [31,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [26,0,0], thread: [32,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [26,0,0], thread: [33,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [26,0,0], thread: [34,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [26,0,0], thread: [35,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [26,0,0], thread: [36,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [26,0,0], thread: [37,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [26,0,0], thread: [38,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [26,0,0], thread: [39,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [26,0,0], thread: [40,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [26,0,0], thread: [41,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [26,0,0], thread: [42,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [26,0,0], thread: [43,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [26,0,0], thread: [44,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [26,0,0], thread: [45,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [26,0,0], thread: [46,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [26,0,0], thread: [47,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [26,0,0], thread: [48,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [26,0,0], thread: [49,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [26,0,0], thread: [50,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [26,0,0], thread: [51,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [26,0,0], thread: [52,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [26,0,0], thread: [53,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [26,0,0], thread: [54,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [26,0,0], thread: [55,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [26,0,0], thread: [56,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [26,0,0], thread: [57,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [26,0,0], thread: [58,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [26,0,0], thread: [59,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [26,0,0], thread: [60,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [26,0,0], thread: [61,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [26,0,0], thread: [62,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
/opt/conda/conda-bld/pytorch_1711403380481/work/aten/src/ATen/native/cuda/Indexing.cu:1290: indexSelectLargeIndex: block: [26,0,0], thread: [63,0,0] Assertion `srcIndex < srcSelectDimSize` failed.
[rank0]:[E ProcessGroupNCCL.cpp:1182] [Rank 0] NCCL watchdog thread terminated with exception: CUDA error: device-side assert triggered
CUDA kernel errors might be asynchronously reported at some other API call, so the stacktrace below might be incorrect.
For debugging consider passing CUDA_LAUNCH_BLOCKING=1.
Compile with `TORCH_USE_CUDA_DSA` to enable device-side assertions.

Exception raised from c10_cuda_check_implementation at /opt/conda/conda-bld/pytorch_1711403380481/work/c10/cuda/CUDAException.cpp:44 (most recent call first):
frame #0: c10::Error::Error(c10::SourceLocation, std::string) + 0x57 (0x7fcff1764d87 in /hpc-home/mahony/miniforge3/envs/transformers/lib/python3.12/site-packages/torch/lib/libc10.so)
frame #1: c10::detail::torchCheckFail(char const*, char const*, unsigned int, std::string const&) + 0x64 (0x7fcff171575f in /hpc-home/mahony/miniforge3/envs/transformers/lib/python3.12/site-packages/torch/lib/libc10.so)
frame #2: c10::cuda::c10_cuda_check_implementation(int, char const*, char const*, int, bool) + 0x118 (0x7fcff18368a8 in /hpc-home/mahony/miniforge3/envs/transformers/lib/python3.12/site-packages/torch/lib/libc10_cuda.so)
frame #3: c10d::ProcessGroupNCCL::WorkNCCL::finishedGPUExecutionInternal() const + 0x6c (0x7fcff292519c in /hpc-home/mahony/miniforge3/envs/transformers/lib/python3.12/site-packages/torch/lib/libtorch_cuda.so)
frame #4: c10d::ProcessGroupNCCL::WorkNCCL::isCompleted() + 0x58 (0x7fcff29292b8 in /hpc-home/mahony/miniforge3/envs/transformers/lib/python3.12/site-packages/torch/lib/libtorch_cuda.so)
frame #5: c10d::ProcessGroupNCCL::workCleanupLoop() + 0x15a (0x7fcff292c9ea in /hpc-home/mahony/miniforge3/envs/transformers/lib/python3.12/site-packages/torch/lib/libtorch_cuda.so)
frame #6: c10d::ProcessGroupNCCL::ncclCommWatchdog() + 0x119 (0x7fcff292d629 in /hpc-home/mahony/miniforge3/envs/transformers/lib/python3.12/site-packages/torch/lib/libtorch_cuda.so)
frame #7: <unknown function> + 0xd3e95 (0x7fd045579e95 in /hpc-home/mahony/miniforge3/envs/transformers/lib/python3.12/site-packages/numexpr/../../../libstdc++.so.6)
frame #8: <unknown function> + 0x89c02 (0x7fd056a89c02 in /lib64/libc.so.6)
frame #9: <unknown function> + 0x10ec40 (0x7fd056b0ec40 in /lib64/libc.so.6)

terminate called after throwing an instance of 'c10::DistBackendError'
  what():  [Rank 0] NCCL watchdog thread terminated with exception: CUDA error: device-side assert triggered
CUDA kernel errors might be asynchronously reported at some other API call, so the stacktrace below might be incorrect.
For debugging consider passing CUDA_LAUNCH_BLOCKING=1.
Compile with `TORCH_USE_CUDA_DSA` to enable device-side assertions.

Exception raised from c10_cuda_check_implementation at /opt/conda/conda-bld/pytorch_1711403380481/work/c10/cuda/CUDAException.cpp:44 (most recent call first):
frame #0: c10::Error::Error(c10::SourceLocation, std::string) + 0x57 (0x7fcff1764d87 in /hpc-home/mahony/miniforge3/envs/transformers/lib/python3.12/site-packages/torch/lib/libc10.so)
frame #1: c10::detail::torchCheckFail(char const*, char const*, unsigned int, std::string const&) + 0x64 (0x7fcff171575f in /hpc-home/mahony/miniforge3/envs/transformers/lib/python3.12/site-packages/torch/lib/libc10.so)
frame #2: c10::cuda::c10_cuda_check_implementation(int, char const*, char const*, int, bool) + 0x118 (0x7fcff18368a8 in /hpc-home/mahony/miniforge3/envs/transformers/lib/python3.12/site-packages/torch/lib/libc10_cuda.so)
frame #3: c10d::ProcessGroupNCCL::WorkNCCL::finishedGPUExecutionInternal() const + 0x6c (0x7fcff292519c in /hpc-home/mahony/miniforge3/envs/transformers/lib/python3.12/site-packages/torch/lib/libtorch_cuda.so)
frame #4: c10d::ProcessGroupNCCL::WorkNCCL::isCompleted() + 0x58 (0x7fcff29292b8 in /hpc-home/mahony/miniforge3/envs/transformers/lib/python3.12/site-packages/torch/lib/libtorch_cuda.so)
frame #5: c10d::ProcessGroupNCCL::workCleanupLoop() + 0x15a (0x7fcff292c9ea in /hpc-home/mahony/miniforge3/envs/transformers/lib/python3.12/site-packages/torch/lib/libtorch_cuda.so)
frame #6: c10d::ProcessGroupNCCL::ncclCommWatchdog() + 0x119 (0x7fcff292d629 in /hpc-home/mahony/miniforge3/envs/transformers/lib/python3.12/site-packages/torch/lib/libtorch_cuda.so)
frame #7: <unknown function> + 0xd3e95 (0x7fd045579e95 in /hpc-home/mahony/miniforge3/envs/transformers/lib/python3.12/site-packages/numexpr/../../../libstdc++.so.6)
frame #8: <unknown function> + 0x89c02 (0x7fd056a89c02 in /lib64/libc.so.6)
frame #9: <unknown function> + 0x10ec40 (0x7fd056b0ec40 in /lib64/libc.so.6)

Exception raised from ncclCommWatchdog at /opt/conda/conda-bld/pytorch_1711403380481/work/torch/csrc/distributed/c10d/ProcessGroupNCCL.cpp:1186 (most recent call first):
frame #0: c10::Error::Error(c10::SourceLocation, std::string) + 0x57 (0x7fcff1764d87 in /hpc-home/mahony/miniforge3/envs/transformers/lib/python3.12/site-packages/torch/lib/libc10.so)
frame #1: <unknown function> + 0xe191e1 (0x7fcff26821e1 in /hpc-home/mahony/miniforge3/envs/transformers/lib/python3.12/site-packages/torch/lib/libtorch_cuda.so)
frame #2: <unknown function> + 0xd3e95 (0x7fd045579e95 in /hpc-home/mahony/miniforge3/envs/transformers/lib/python3.12/site-packages/numexpr/../../../libstdc++.so.6)
frame #3: <unknown function> + 0x89c02 (0x7fd056a89c02 in /lib64/libc.so.6)
frame #4: <unknown function> + 0x10ec40 (0x7fd056b0ec40 in /lib64/libc.so.6)

[2024-10-03 21:56:25,681] torch.distributed.elastic.multiprocessing.api: [ERROR] failed (exitcode: -6) local_rank: 0 (pid: 442973) of binary: /hpc-home/mahony/miniforge3/envs/transformers/bin/python
Traceback (most recent call last):
  File "/hpc-home/mahony/miniforge3/envs/transformers/bin/torchrun", line 33, in <module>
    sys.exit(load_entry_point('torch==2.2.2', 'console_scripts', 'torchrun')())
             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/hpc-home/mahony/miniforge3/envs/transformers/lib/python3.12/site-packages/torch/distributed/elastic/multiprocessing/errors/__init__.py", line 347, in wrapper
    return f(*args, **kwargs)
           ^^^^^^^^^^^^^^^^^^
  File "/hpc-home/mahony/miniforge3/envs/transformers/lib/python3.12/site-packages/torch/distributed/run.py", line 812, in main
    run(args)
  File "/hpc-home/mahony/miniforge3/envs/transformers/lib/python3.12/site-packages/torch/distributed/run.py", line 803, in run
    elastic_launch(
  File "/hpc-home/mahony/miniforge3/envs/transformers/lib/python3.12/site-packages/torch/distributed/launcher/api.py", line 135, in __call__
    return launch_agent(self._config, self._entrypoint, list(args))
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/hpc-home/mahony/miniforge3/envs/transformers/lib/python3.12/site-packages/torch/distributed/launcher/api.py", line 268, in launch_agent
    raise ChildFailedError(
torch.distributed.elastic.multiprocessing.errors.ChildFailedError: 
============================================================
/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/Soy_expression_prediction/agro_nt_scripts/train_ia3_regression.py FAILED
------------------------------------------------------------
Failures:
  <NO_OTHER_FAILURES>
------------------------------------------------------------
Root Cause (first observed failure):
[0]:
  time      : 2024-10-03_21:56:25
  host      : t1024n3.hpccluster
  rank      : 0 (local_rank: 0)
  exitcode  : -6 (pid: 442973)
  error_file: <N/A>
  traceback : Signal 6 (SIGABRT) received by PID 442973
============================================================

ERROR conda.cli.main_run:execute(47): `conda run torchrun --nproc_per_node=1 /ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/Soy_expression_prediction/agro_nt_scripts/train_ia3_regression.py --model_name_or_path /ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/dnabert/agro-nucleotide-transformer-1b --data_path /ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/Soy_expression_prediction/intermediate_data/soy_1500up_0down_42_log2 --kmer -1 --run_name ia3 --model_max_length 4608 --per_device_train_batch_size 1 --per_device_eval_batch_size 1 --gradient_accumulation_steps 32 --learning_rate 3e-4 --num_train_epochs 2 --fp16 --save_steps 500 --output_dir /ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/Soy_expression_prediction/intermediate_data/soy_1500up_0down_42_log2/3e-4 --evaluation_strategy steps --eval_steps 500 --warmup_steps 50 --logging_steps 500 --overwrite_output_dir True --log_level info --find_unused_parameters False` failed. (See above for error)
