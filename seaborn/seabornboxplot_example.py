#!/usr/bin/env python3

import numpy as np
import seaborn as sns
from matplotlib import pyplot as plt

sns.set()
sns.set_style('whitegrid')
sns.set_palette('Set3')

tips = sns.load_dataset("tips")

print(tips.head())
fig = plt.figure()
ax = fig.add_subplot(1, 1, 1)
ax.set_ylim(0, 50)

medians = tips.groupby(['day'])['total_bill'].median().values
median_labels = [str(np.round(s, 2)) for s in medians]
ax = sns.boxplot(x="day", y="total_bill", data=tips, showfliers=False)
sns.stripplot(x='day', y='total_bill', data=tips,
              jitter=False, color='black', ax=ax)

pos = range(len(medians))
for tick, label in zip(pos, ax.get_xticklabels()):
    ax.text(pos[tick], medians[tick], median_labels[tick],
            color='w', weight='semibold', size=8,
            bbox=dict(facecolor='#445A64'))

plt.show()
