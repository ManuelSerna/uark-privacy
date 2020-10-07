#*********************************
# Generate random noise according to laplace distribution
#*********************************
import numpy as np
import matplotlib.pyplot as plt
loc = 0.0
n = 1000 # number of noise values to produce
scale = 1.0
s = np.random.laplace(loc, scale, n)# generate n random points
plt.plot(s)
s.sort()
print('100th percentile: ', s[-1])
print('75th percentile:  ', s[int(n*0.75)])
print('50th percentile:  ', s[int(n*0.5)])
print('25th percentile:  ', s[int(n*0.25)])
print('min noise value:  ', s[0])
print('avg noise value:  ', np.average(s))
plt.show()
