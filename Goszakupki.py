import requests
from lxml import html
from lxml import etree
import pandas as pd
import os
from datetime import date
import datetime


def get_request(url, headers, params):
    tag = params['searchString']

    page = requests.get(url, headers=header, params=params)
    page.encoding = 'utf-8'
    myparser = etree.HTMLParser(encoding="utf-8")
    dom = etree.HTML(page.content, parser=myparser)

    names = dom.xpath("//*[@class='registry-entry__body']//*/text()")

    dict_for_del_1 = ['\n', ' ']
    f = []
    for el in names:
        for item in el:
            if item not in dict_for_del_1:
                el = el.replace('  ', '')
                el = el.replace('\n', '')
                f.append(el)
                break

    for i, el in enumerate(f):
        if el == 'Организация, осуществляющаяразмещение':
            f[i] = 'Заказчик'

    names = []

    for i in range(len(f) - 1):
        name = ''
        k = 1
        if f[i] == 'Объект закупки':
            while f[i + k] != 'Заказчик' and i + k <= (len(f) - 1):
                name = name + f[i + k]
                k += 1
            names.append(name)
            i += k

    references = dom.xpath("//*[@class='search-registry-entrys-block']/div/div/div[1]/div[1]/div[2]/div[1]/a/@href")
    source = 'https://zakupki.gov.ru/'
    for i, el in enumerate(references):
        references[i] = source + el

    price = dom.xpath("//*[@class='search-registry-entrys-block']/div/div/div[2]/div[1]//text()")
    temp = [el for el in price if el.find(
        'Начальная цена') == -1 and el != '\n                        \n                            ' and el != '\n                            ']
    # print(*temp, sep = '\n')
    res = ''
    for el in temp:
        res += el
    temp = res.split(
        '\n                        \n                        \n                        \n                            \n                                \n                                \n                                    \n                                \n                            \n                        \n                    ', )
    price = temp[:-1]

    price_final = []
    for el in price:
        el = el.replace(',', '.')
        temp = el.split('\xa0')
        result = ''
        for item in temp:
            result = result + str(item) + ' '
        price_final.append(result.replace(' ₽\n                             ', ''))

    seen = ['not' for el in names]
    tags = [tag for el in names]

    # posted = dom.xpath("//*[@class='search-registry-entrys-block']/div/div/div[2]/div[2]/div[1]/div[1]/div[2]/text()")

    # finish = dom.xpath("//*[@class='search-registry-entrys-block']/div/div/div[2]/div[2]/div[3]/text()")

    # 'posted': posted, 'finish': finish

    df = pd.DataFrame({'name': names, 'price': price_final, 'refers': references, 'tag': tags, 'seen': seen})

    return df

def get_info_from_1_tag(tag, url, header, params):
    df = pd.DataFrame()
    params['searchString'] = str(tag)
    params['pageNumber'] = str(1)
    while True:
        print(f'{params["searchString"]}: page {params["pageNumber"]}')
        temp = get_request(url, header, params)
        if temp.shape[0] > 0:
            df = pd.concat([df, temp], ignore_index=True)
            params['pageNumber'] = str(int(params['pageNumber']) + 1)
        else:
            break
    return df


def get_path_to_last_csv(path):
    path_to_history_folder = os.path.join(path, 'gos_history')
    time = [el.replace('.txt', '') for el in os.listdir(path_to_history_folder)]
    time = [datetime.datetime.strptime(el, '%Y-%m-%d_%H-%M-%S') for el in time]

    max_time = time[0]
    for el in time:
        if el > max_time:
            max_time = el

    filename = str(max_time.strftime("%Y-%m-%d_%H-%M-%S")) + '.txt'
    path_to_save = os.path.join(path, 'gos_history')
    path_to_save = os.path.join(path_to_save, filename)

    return path_to_save


url = 'https://zakupki.gov.ru/epz/order/extendedsearch/results.html'
header = {
    'User-Agent' : 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36'
}

params = {
    'searchString': 'топографический',
    'morphology' : 'on',
    'search-filter' : 'Дате+размещения',
    'pageNumber' : '1',
    'sortDirection': 'false',
    'recordsPerPage' : '_50',
    'showLotsInfoHidden' : 'false',
    'sortBy' : 'PUBLISH_DATE',
    'fz44' : 'on',
    'fz223' : 'on',
    'af' : 'on',
    'currencyIdGeneral' : '-1'
}

path = os.getcwd()


if not os.path.exists(os.path.join(path, 'gos_history')):
    os.mkdir(os.path.join(path, 'gos_history'))


if not os.path.exists(os.path.join(path, 'gos_order.txt')):
    print('Отсутствует файл с тегами!')
else:
    with open(os.path.join(path, 'gos_order.txt'), 'r', encoding='utf-8') as f:
        list_of_tags = [el for el in f.read().split('\n') if el != '\n']
    df = pd.DataFrame()
    for el in list_of_tags:
        df = pd.concat([df, get_info_from_1_tag(el, url, header, params)], ignore_index=True)


try:
    previous = list(pd.read_csv(get_path_to_last_csv(path), sep='\t', encoding='utf-8', index_col=0)['refers'].values)

    for i in range(len(df)):
        if df['refers'][i] in previous:
            df['seen'][i] = 'yes'
except:
    pass
finally:
    df = df.sort_values(by='seen', ascending=True, ignore_index=True)
    df = df.drop_duplicates(['refers'], ignore_index=True)


filename = str(datetime.datetime.now().strftime("%Y-%m-%d_%H-%M-%S")) + '.txt'
path_to_save = os.path.join(path, 'gos_history')
path_to_save = os.path.join(path_to_save, filename)
print(f"список сохранен: {path_to_save}")
df.to_csv(path_to_save, sep='\t', encoding='utf-8')