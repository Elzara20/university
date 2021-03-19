from pybrain.tools.shortcuts import buildNetwork
from pybrain.structure import TanhLayer,SigmoidLayer, FeedForwardNetwork
from pybrain.datasets import SupervisedDataSet
from pybrain.supervised.trainers import BackpropTrainer
import pandas as pd
import numpy as np
import csv


print('Read data...')
df = pd.read_csv('courseW.csv',header=0).head(1000)
#print(df)
data = df.values

#train_output = data.loc[:,['year', 'month', 'day', 'hour', 'min', 'sec']]
train_output = data[:,0]
train_data = data[:,1:]

#print(train_output)
#print("______________________________________")
#print(train_data)

nn = buildNetwork(6, 5, 1, bias=True, hiddenclass=SigmoidLayer)


_gate = SupervisedDataSet(6, 1)

for i in range(0, len(train_output)) :
   _gate.addSample(train_data[i], train_output[i])


trainer = BackpropTrainer(nn, _gate)

for epoch in range(1000):
   trainer.train()
trainer.testOnData(dataset=_gate, verbose = True)