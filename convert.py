import pandas as pd
import os

perfdf = pd.read_excel('stats.xlsx')
perfdf.to_latex('stats.tex')
statsdf = pd.read_excel('intervals.xlsx')
statsdf.to_latex('intervals.tex')
uncertdf = pd.read_excel('numneeded.xlsx')
uncertdf.to_latex('numneeded.tex')
perfdf = pd.read_excel('results.xlsx')
perfdf.to_latex('results.tex')
cpscompdf = pd.read_excel('cpscomp.xlsx')
cpscompdf.to_latex('cpscomp.tex')
propdf = pd.read_excel('proptime.xlsx')
propdf.to_latex('proptime.tex')