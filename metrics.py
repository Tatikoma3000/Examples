#!/usr/bin/env python
# coding: utf-8

# In[1]:


import numpy as np
import pandas as pd


# In[2]:


def hit_rate(recommended_list, bought_list):
    '''
    Hit rate = (был ли хотя бы 1 релевантный товар среди рекомендованных)
    '''
    bought_list = np.array(bought_list)
    recommended_list = np.array(recommended_list)
    
    flags = np.isin(recommended_list, bought_list)
    hit_rate = int(flags.sum() > 0)  
    
    return hit_rate


# In[3]:


def hit_rate_at_k(recommended_list, bought_list, k=5):
    '''
    Hit rate@k = (был ли хотя бы 1 релевантный товар среди топ-k рекомендованных)
    '''
    bought_list = np.array(bought_list)
    recommended_list = np.array(recommended_list)
    
    flags = np.isin(recommended_list[:k], bought_list,)   
    hit_rate = int(flags.sum() > 0)
    
    return hit_rate


# In[4]:


def precision(recommended_list, bought_list):
    '''
    Индикаторная функция, показывающая, что пользователь  i  провзаимойдествовал с объектом  j 
    Precision - доля релевантных товаров среди рекомендованных = Какой % рекомендованных товаров юзер купил
    Precision= (# of recommended items that are relevant) / (# of recommended items)
    '''
    
    bought_list = np.array(bought_list)
    recommended_list = np.array(recommended_list)
    
    flags = np.isin(bought_list, recommended_list)
    
    precision = flags.sum() / len(recommended_list)
    
    return precision


# In[5]:


def precision_at_k(recommended_list, bought_list, k=5):
    '''
    Индикаторная функция, показывающая, что пользователь  i  провзаимойдествовал с объектом  j 
    Precision - доля релевантных товаров среди рекомендованных = Какой % рекомендованных товаров юзер купил
    Precision@k = (# of recommended items @k that are relevant) / (# of recommended items @k)
    '''
    
    bought_list = np.array(bought_list)
    recommended_list = np.array(recommended_list)
    
    bought_list = bought_list
    recommended_list = recommended_list[:k]
    
    flags = np.isin(bought_list, recommended_list)
    
    precision = flags.sum() / len(recommended_list)
    
    
    return precision


# In[6]:


def money_precision_at_k(recommended_list, bought_list, prices_recommended, k=5):
    '''
    Индикаторная функция, показывающая, что пользователь  i  провзаимойдествовал с объектом  j 
    Precision - доля релевантных товаров среди рекомендованных = Какой % рекомендованных товаров юзер купил
    Money Precision@k = (revenue of recommended items @k that are relevant) / (revenue of recommended items @k)
    '''
    
    bought_list = np.array(bought_list)
    recommended_list = np.array(recommended_list)
    prices_recommended = np.array(prices_recommended)
    
    bought_list = bought_list
    recommended_list = recommended_list[:k]
    prices_recommended = prices_recommended[:k]
    
    flags = np.isin(bought_list, recommended_list)
    
    precision = (flags*prices_recommended).sum() / prices_recommended.sum()
     
    return precision


# In[7]:


def recall(recommended_list, bought_list):
    '''
    Recall - доля рекомендованных товаров среди релевантных = Какой % купленных товаров был среди рекомендованных
    Обычно используется для моделей пре-фильтрации товаров (убрать те товары, которые точно не будем рекомендовать)
    Recall= (# of recommended items that are relevant) / (# of relevant items)
    '''
    bought_list = np.array(bought_list)
    recommended_list = np.array(recommended_list)
    
    flags = np.isin(bought_list, recommended_list)
    
    recall = flags.sum() / len(bought_list)
    
    return recall


# In[8]:


def recall_at_k(recommended_list, bought_list, k=5):
    '''
    Recall - доля рекомендованных товаров среди релевантных = Какой % купленных товаров был среди рекомендованных
    Обычно используется для моделей пре-фильтрации товаров (убрать те товары, которые точно не будем рекомендовать)
    Recall@k = (# of recommended items @k that are relevant) / (# of relevant items)
    '''
    bought_list = np.array(bought_list)
    recommended_list = np.array(recommended_list)
    
    recommended_list = recommended_list[:k]

    flags = np.isin(bought_list, recommended_list)
    
    recall = flags.sum() / len(bought_list)

    return recall


# In[9]:


def money_recall_at_k(recommended_list, bought_list, prices_recommended, prices_bought, k=5):
    '''
    Recall - доля рекомендованных товаров среди релевантных = Какой % купленных товаров был среди рекомендованных
    Обычно используется для моделей пре-фильтрации товаров (убрать те товары, которые точно не будем рекомендовать)
    Money Recall@k = (revenue of recommended items @k that are relevant) / (revenue of relevant items)
    '''
    bought_list = np.array(bought_list)
    recommended_list = np.array(recommended_list)
    prices_recommended = np.array(prices_recommended)
    prices_bought = np.array(prices_bought)
    
    recommended_list = recommended_list[:k]
    prices_recommended = prices_recommended[:k]
    
    flags = np.isin(bought_list, recommended_list)
    
    mrk = (flags * prices_recommended).sum() / prices_bought.sum()
    
    return mrk


# In[10]:


def ap_k(recommended_list, bought_list, k=5):
    '''
    AP@k - average precision at k
    Precision - доля релевантных товаров среди рекомендованных = Какой % рекомендованных товаров юзер купил
    Precision@k = (# of recommended items @k that are relevant) / (# of recommended items @k)
    '''
    bought_list = np.array(bought_list)
    recommended_list = np.array(recommended_list)
    
    flags = np.isin(recommended_list, bought_list)
    
    if sum(flags) == 0:
        return 0
    
    sum_ = 0
    for i in range(k):
        
        if flags[i]:
            p_k = precision_at_k(recommended_list, bought_list, k=i+1)
            sum_ += p_k
            
    result = sum_ / k
    
    return result


# In[11]:


def reciprocal_rank_k(recommended_list, bought_list):
    '''
    Mean Reciprocal Rank
    Считаем для первых k рекоммендаций
    Найти ранк первого релевантного предсказания  ku 
    Посчитать reciprocal rank =  1 / ku
    '''
    
    bought_list = np.array(bought_list)
    recommended_list = np.array(recommended_list)
    
    flags = np.isin(bought_list, recommended_list)
    
    mrrk = 1 / np.argmax(flags)
    
    return mrrk


# In[12]:


def dcg_at_k(recommended_list, bought_list, k=5):
    '''
    Normalized discounted cumulative gain
    𝐷𝐶𝐺@𝐾(𝑖)=∑ (1 /log2(𝑗+1))
    '''

    bought_list = np.array(bought_list)
    recommended_list = np.array(recommended_list)

    recommended_list = recommended_list[:k]
    
    flags = np.isin(bought_list, recommended_list)
    
    numerates = np.array([el for el in range(recommended_list.shape[0] + 1)])
    
    dcg_k = flags * 1 / np.log(numerates + 2)
    
    return dcg_k


# In[13]:


def ndcg_at_k(recommended_list, bought_list, k=5):
    '''
    DCG@K(i)=∑(1/log2(j+1))
    nDCG@K(i)=DCG@K(i) / IDCG@K(i)
    '''
    bought_list = np.array(bought_list)
    recommended_list = np.array(recommended_list)
    
    dcg = dcg_at_k(recommended_list, bought_list, k=k)
    idcg = max(dcg)

    return sum(dcg) / idcg

