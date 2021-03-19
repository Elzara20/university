import numpy as np
import pandas as pd
pr=pd.read_csv('courseWork.csv')
data=pr.values
w=np.array([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])
print(len(data))
def target(x):
	for i in range(len(data)):
		for j in range(10):
			if (j>=1):
				if (x[j]==data[i][j]).all():
					return 1
					break
				else:
					return 0
					continue
def predict(x):
	sum=w.dot(list(map(float,x)))
	if sum>0:
		return 1
	else:
		return 0

perfect=False
while not perfect:
	perfect=True
	for p in data:
		if predict(p)!=target(p):
			perfect=False
			if predict(p)==0:
				w+=p
			else:
				w-=p
	
				
print(w)
