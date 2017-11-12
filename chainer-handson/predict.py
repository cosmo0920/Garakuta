#!/usr/local/bin/python
# -*- coding: utf-8 -*-

import argparse
import pkg_resources

import chainer
from chainer import serializers
import chainer.links as L
from chainer.cuda import to_gpu
from chainer.cuda import to_cpu
from chainer.datasets import cifar
from model import MyModel
from chainer.datasets import get_cifar10
from chainer.datasets import get_cifar100

matplotlib_pkg = None
try:
    matplotlib_pkg = pkg_resources.get_distribution('matplotlib')
    import matplotlib.pyplot as plt
except pkg_resources.DistributionNotFound:
    pass

cls_names = ['airplane', 'automobile', 'bird', 'cat', 'deer',
             'dog', 'frog', 'horse', 'ship', 'truck']

def predict(model, image_id, test):
    x, t = test[image_id]
    model.to_cpu()
    y = model.predictor(x[None, ...]).data.argmax(axis=1)[0]
    print('predicted_label:', cls_names[y])
    print('answer:', cls_names[t])

    matplotlib_pkg = None
    if matplotlib_pkg:
        plt.imshow(x.transpose(1, 2, 0))
        plt.show()

def main():
    # define options
    parser = argparse.ArgumentParser(
        description='Training script of DenseNet on CIFAR-10 dataset')
    parser.add_argument('--gpu', '-g', type=int, default=-1,
                        help='GPU ID (negative value indicates CPU)')
    parser.add_argument('--out', '-o', default='result',
                        help='Output directory')
    parser.add_argument('--numlayers', '-L', type=int, default=40,
                        help='Number of layers')
    args = parser.parse_args()

    print('Using CIFAR10 dataset.')
    class_labels = 10
    train, test = get_cifar10()

    # setup model
    model =  L.Classifier(MyModel(10))

    if args.gpu >= 0:
        chainer.cuda.get_device(args.gpu).use()
        model.to_gpu()


    # そのオブジェクトに保存済みパラメータをロードする
    serializers.load_npz('result/model_20.npz', model)

    for i in range(10, 15):
        predict(model, i, test)


if __name__ == '__main__':
    main()
