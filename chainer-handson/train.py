#!/usr/bin/env python
# -*- coding: utf-8 -*_

import argparse

import chainer
import chainer.functions as F
import chainer.links as L
from model import MyModel

from chainer.datasets import cifar
from chainer import iterators
from chainer import optimizers
from chainer import training
from chainer.training import extensions

def train(model_object, train_dataset=None, test_dataset=None):
    # define options
    parser = argparse.ArgumentParser(
        description='Training script of Tiny Model on CIFAR-10 dataset')
    parser.add_argument('--epoch', '-e', type=int, default=20,
                        help='Number of epochs to train')
    parser.add_argument('--gpu', '-g', type=int, default=-1,
                        help='GPU ID (negative value indicates CPU)')
    parser.add_argument('--initmodel',
                        help='Initialize the model from given file')
    parser.add_argument('--resume', '-r', default='',
                        help='Initialize the trainer from given file')
    parser.add_argument('--out', '-o', default='result',
                        help='Output directory')
    parser.add_argument('--batchsize', '-b', type=int, default=64,
                        help='Validation minibatch size')
    parser.add_argument('--numlayers', '-L', type=int, default=40,
                        help='Number of layers')
    parser.add_argument('--growth', '-G', type=int, default=12,
                        help='Growth rate parameter')
    parser.add_argument('--dropout', '-D', type=float, default=0.2,
                        help='Dropout ratio')
    parser.add_argument('--dataset', type=str, default='cifar10',
                        choices=('cifar10', 'cifar100'),
                        help='Dataset used for training (Default is cifar10)')
    args = parser.parse_args()

    # 1. Dataset
    if args.dataset == 'cifar10':
        train, test = cifar.get_cifar10()
    elif args.dataset == 'cifar10':
        train, test = cifar.get_cifar100()

    # 2. Iterator
    train_iter = iterators.SerialIterator(train, args.batchsize)
    test_iter = iterators.SerialIterator(test, args.batchsize, False, False)

    # 3. Model
    model = L.Classifier(model_object)
    if args.gpu >= 0:
        model.to_gpu(args.gpu)

    # 4. Optimizer
    optimizer = optimizers.Adam()
    optimizer.setup(model)

    # 5. Updater
    updater = training.StandardUpdater(train_iter, optimizer, device=args.gpu)

    # 6. Trainer
    trainer = training.Trainer(updater, (args.epoch, 'epoch'), out=args.out)

    # 7. Evaluator

    class TestModeEvaluator(extensions.Evaluator):

        def evaluate(self):
            model = self.get_target('main')
            model.train = False
            ret = super(TestModeEvaluator, self).evaluate()
            model.train = True
            return ret

    trainer.extend(extensions.LogReport())
    trainer.extend(TestModeEvaluator(test_iter, model, device=args.gpu))
    trainer.extend(extensions.PrintReport(['epoch', 'main/loss', 'main/accuracy', 'validation/main/loss', 'validation/main/accuracy', 'elapsed_time']))
    trainer.extend(extensions.PlotReport(['main/loss', 'validation/main/loss'], x_key='epoch', file_name='loss.png'))
    trainer.extend(extensions.PlotReport(['main/accuracy', 'validation/main/accuracy'], x_key='epoch', file_name='accuracy.png'))
    trainer.extend(extensions.snapshot(), trigger=(10, 'epoch'))
    trainer.extend(extensions.snapshot_object(
                   model, 'model_{.updater.epoch}.npz'))
    trainer.run()
    del trainer

    return model

def main():
    model = train(MyModel(10))

if __name__ == '__main__':
    main()
