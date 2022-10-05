""" Trabalho Prático do Módulo 4
Pipeline de Dados - Enem 2019
Atividades:
Você deverá desempenhar as seguintes atividades:

Extrair, de maneira programática, os dados do ENEM 2019.
Filtrar apenas os alunos do estado de Minas Gerais.
Salvar um arquivo CSV com os dados já limpos em seu computador.
Escrever os dados numa tabela relacional em uma base de dados de sua escolha (MySQL, PostgreSQL, SQL Server etc.).
Site do Ibep >> Microdados >> Enem:

https://www.gov.br/inep/pt-br/acesso-a-informacao/dados-abertos/microdados/enem

Url do zip do microdados do Enem-2019:

https://download.inep.gov.br/microdados/microdados_enem_2019.zip

Extração dos dados
Extrair, de maneira programática, os dados do ENEM 2019. """

In [1]:
# Importar bibliotecas

import pandas as pd 
import numpy as np 
import zipfile
import requests
from io import BytesIO
import os
In [2]:
# Criar um diretório para armazenar o conteúdo do ENEM

# Medir o tempo que o python vai gastar para executar a celula.
%%time

os.makedirs('./enem2019', exist_ok=True)
In [7]:
# Define a url 
url = "https://download.inep.gov.br/microdados/microdados_enem_2019.zip"

# Download do conteúdo da url
# stream=True, este é para garantir que a conexao fique ativa até o termino.
filebytes = BytesIO(
    requests.get(url, stream=True).content
)

# Descompactação do zip
myzip = zipfile.ZipFile(filebytes)

# Pasta destino da descompactação
myzip.extractall("./enem2019")
In [124]:
# Leitura dos dados


# O que o dask faz: é um implementação para trabalhar com dados, particionando no disco, executando de maneira otimizada.
# trocar o pd.read_csv por dd.read_csv
# se der erro, pegar o que o erro sujere e colar abaixo, depois do latin-1
import dask.dataframe as dd

enem = pd.read_csv("./enem2019/DADOS/MICRODADOS_ENEM_2019.csv", 
                    sep = ";", 
                    decimal = ".",
                    encoding='latin1')
---------------------------------------------------------------------------
KeyboardInterrupt                         Traceback (most recent call last)
<ipython-input-124-e8bc884ffc67> in <module>
      1 # Leitura dos dados
      2 
----> 3 enem = pd.read_csv("./enem2019/DADOS/MICRODADOS_ENEM_2019.csv", 
      4                     sep = ";",
      5                     decimal = ".",
	  6                     encoding = "latin1"

~\anaconda3\lib\site-packages\pandas\io\parsers.py in read_csv(filepath_or_buffer, sep, delimiter, header, names, index_col, usecols, squeeze, prefix, mangle_dupe_cols, dtype, engine, converters, true_values, false_values, skipinitialspace, skiprows, skipfooter, nrows, na_values, keep_default_na, na_filter, verbose, skip_blank_lines, parse_dates, infer_datetime_format, keep_date_col, date_parser, dayfirst, cache_dates, iterator, chunksize, compression, thousands, decimal, lineterminator, quotechar, quoting, doublequote, escapechar, comment, encoding, dialect, error_bad_lines, warn_bad_lines, delim_whitespace, low_memory, memory_map, float_precision, storage_options)
    608     kwds.update(kwds_defaults)
    609 
--> 610     return _read(filepath_or_buffer, kwds)
    611 
    612 

~\anaconda3\lib\site-packages\pandas\io\parsers.py in _read(filepath_or_buffer, kwds)
    466 
    467     with parser:
--> 468         return parser.read(nrows)
    469 
    470 

~\anaconda3\lib\site-packages\pandas\io\parsers.py in read(self, nrows)
   1055     def read(self, nrows=None):
   1056         nrows = validate_integer("nrows", nrows)
-> 1057         index, columns, col_dict = self._engine.read(nrows)
   1058 
   1059         if index is None:

~\anaconda3\lib\site-packages\pandas\io\parsers.py in read(self, nrows)
   2059     def read(self, nrows=None):
   2060         try:
-> 2061             data = self._reader.read(nrows)
   2062         except StopIteration:
   2063             if self._first_chunk:

pandas\_libs\parsers.pyx in pandas._libs.parsers.TextReader.read()

pandas\_libs\parsers.pyx in pandas._libs.parsers.TextReader._read_low_memory()

pandas\_libs\parsers.pyx in pandas._libs.parsers.TextReader._read_rows()

pandas\_libs\parsers.pyx in pandas._libs.parsers.TextReader._convert_column_data()

pandas\_libs\parsers.pyx in pandas._libs.parsers.TextReader._convert_tokens()

pandas\_libs\parsers.pyx in pandas._libs.parsers.TextReader._convert_with_dtype()

~\anaconda3\lib\site-packages\pandas\core\dtypes\common.py in is_categorical_dtype(arr_or_dtype)
    535 
    536 
--> 537 def is_categorical_dtype(arr_or_dtype) -> bool:
    538     
    539     Check whether an array-like or dtype is of the Categorical dtype.

KeyboardInterrupt: 
In [5]:
enem
Out[5]:
NU_INSCRICAO	NU_ANO	CO_MUNICIPIO_RESIDENCIA	NO_MUNICIPIO_RESIDENCIA	CO_UF_RESIDENCIA	SG_UF_RESIDENCIA	NU_IDADE	TP_SEXO	TP_ESTADO_CIVIL	TP_COR_RACA	...	Q016	Q017	Q018	Q019	Q020	Q021	Q022	Q023	Q024	Q025
0	190001595656	2019	3552205	Sorocaba	35	SP	36.0	M	1	3	...	A	A	A	A	A	A	C	A	C	B
1	190001421546	2019	2910800	Feira de Santana	29	BA	23.0	M	1	1	...	A	A	A	B	A	A	E	A	A	B
2	190001133210	2019	2304400	Fortaleza	23	CE	39.0	F	1	3	...	A	A	A	B	A	A	C	A	A	B
3	190001199383	2019	1721000	Palmas	17	TO	25.0	F	1	1	...	A	A	A	C	A	B	D	A	B	B
4	190001237802	2019	3118601	Contagem	31	MG	22.0	F	1	1	...	B	A	A	B	A	A	C	B	B	B
...	...	...	...	...	...	...	...	...	...	...	...	...	...	...	...	...	...	...	...	...	...
5095265	190006074437	2019	5300108	Bras�lia	53	DF	41.0	F	4	3	...	B	A	A	B	A	A	B	B	A	B
5095266	190005429225	2019	1302603	Manaus	13	AM	20.0	M	1	3	...	A	A	A	B	B	A	E	A	A	B
5095267	190006087652	2019	4302105	Bento Gon�alves	43	RS	21.0	M	0	0	...	A	A	A	B	A	A	C	B	B	B
5095268	190006087653	2019	4302105	Bento Gon�alves	43	RS	22.0	M	0	0	...	B	A	A	C	B	B	A	A	A	B
5095269	190006087654	2019	4302105	Bento Gon�alves	43	RS	21.0	F	0	0	...	A	A	A	B	A	A	B	B	B	B
5095270 rows × 136 columns

Filtrar apenas os alunos do estado de Minas Gerais

In [6]:
dict(enem.dtypes)
Out[6]:
{'NU_INSCRICAO': dtype('int64'),
 'NU_ANO': dtype('int64'),
 'CO_MUNICIPIO_RESIDENCIA': dtype('int64'),
 'NO_MUNICIPIO_RESIDENCIA': dtype('O'),
 'CO_UF_RESIDENCIA': dtype('int64'),
 'SG_UF_RESIDENCIA': dtype('O'),
 'NU_IDADE': dtype('float64'),
 'TP_SEXO': dtype('O'),
 'TP_ESTADO_CIVIL': dtype('int64'),
 'TP_COR_RACA': dtype('int64'),
 'TP_NACIONALIDADE': dtype('int64'),
 'CO_MUNICIPIO_NASCIMENTO': dtype('float64'),
 'NO_MUNICIPIO_NASCIMENTO': dtype('O'),
 'CO_UF_NASCIMENTO': dtype('float64'),
 'SG_UF_NASCIMENTO': dtype('O'),
 'TP_ST_CONCLUSAO': dtype('int64'),
 'TP_ANO_CONCLUIU': dtype('int64'),
 'TP_ESCOLA': dtype('int64'),
 'TP_ENSINO': dtype('float64'),
 'IN_TREINEIRO': dtype('int64'),
 'CO_ESCOLA': dtype('float64'),
 'CO_MUNICIPIO_ESC': dtype('float64'),
 'NO_MUNICIPIO_ESC': dtype('O'),
 'CO_UF_ESC': dtype('float64'),
 'SG_UF_ESC': dtype('O'),
 'TP_DEPENDENCIA_ADM_ESC': dtype('float64'),
 'TP_LOCALIZACAO_ESC': dtype('float64'),
 'TP_SIT_FUNC_ESC': dtype('float64'),
 'IN_BAIXA_VISAO': dtype('int64'),
 'IN_CEGUEIRA': dtype('int64'),
 'IN_SURDEZ': dtype('int64'),
 'IN_DEFICIENCIA_AUDITIVA': dtype('int64'),
 'IN_SURDO_CEGUEIRA': dtype('int64'),
 'IN_DEFICIENCIA_FISICA': dtype('int64'),
 'IN_DEFICIENCIA_MENTAL': dtype('int64'),
 'IN_DEFICIT_ATENCAO': dtype('int64'),
 'IN_DISLEXIA': dtype('int64'),
 'IN_DISCALCULIA': dtype('int64'),
 'IN_AUTISMO': dtype('int64'),
 'IN_VISAO_MONOCULAR': dtype('int64'),
 'IN_OUTRA_DEF': dtype('int64'),
 'IN_GESTANTE': dtype('int64'),
 'IN_LACTANTE': dtype('int64'),
 'IN_IDOSO': dtype('int64'),
 'IN_ESTUDA_CLASSE_HOSPITALAR': dtype('int64'),
 'IN_SEM_RECURSO': dtype('int64'),
 'IN_BRAILLE': dtype('int64'),
 'IN_AMPLIADA_24': dtype('int64'),
 'IN_AMPLIADA_18': dtype('int64'),
 'IN_LEDOR': dtype('int64'),
 'IN_ACESSO': dtype('int64'),
 'IN_TRANSCRICAO': dtype('int64'),
 'IN_LIBRAS': dtype('int64'),
 'IN_TEMPO_ADICIONAL': dtype('int64'),
 'IN_LEITURA_LABIAL': dtype('int64'),
 'IN_MESA_CADEIRA_RODAS': dtype('int64'),
 'IN_MESA_CADEIRA_SEPARADA': dtype('int64'),
 'IN_APOIO_PERNA': dtype('int64'),
 'IN_GUIA_INTERPRETE': dtype('int64'),
 'IN_COMPUTADOR': dtype('int64'),
 'IN_CADEIRA_ESPECIAL': dtype('int64'),
 'IN_CADEIRA_CANHOTO': dtype('int64'),
 'IN_CADEIRA_ACOLCHOADA': dtype('int64'),
 'IN_PROVA_DEITADO': dtype('int64'),
 'IN_MOBILIARIO_OBESO': dtype('int64'),
 'IN_LAMINA_OVERLAY': dtype('int64'),
 'IN_PROTETOR_AURICULAR': dtype('int64'),
 'IN_MEDIDOR_GLICOSE': dtype('int64'),
 'IN_MAQUINA_BRAILE': dtype('int64'),
 'IN_SOROBAN': dtype('int64'),
 'IN_MARCA_PASSO': dtype('int64'),
 'IN_SONDA': dtype('int64'),
 'IN_MEDICAMENTOS': dtype('int64'),
 'IN_SALA_INDIVIDUAL': dtype('int64'),
 'IN_SALA_ESPECIAL': dtype('int64'),
 'IN_SALA_ACOMPANHANTE': dtype('int64'),
 'IN_MOBILIARIO_ESPECIFICO': dtype('int64'),
 'IN_MATERIAL_ESPECIFICO': dtype('int64'),
 'IN_NOME_SOCIAL': dtype('int64'),
 'CO_MUNICIPIO_PROVA': dtype('int64'),
 'NO_MUNICIPIO_PROVA': dtype('O'),
 'CO_UF_PROVA': dtype('int64'),
 'SG_UF_PROVA': dtype('O'),
 'TP_PRESENCA_CN': dtype('int64'),
 'TP_PRESENCA_CH': dtype('int64'),
 'TP_PRESENCA_LC': dtype('int64'),
 'TP_PRESENCA_MT': dtype('int64'),
 'CO_PROVA_CN': dtype('float64'),
 'CO_PROVA_CH': dtype('float64'),
 'CO_PROVA_LC': dtype('float64'),
 'CO_PROVA_MT': dtype('float64'),
 'NU_NOTA_CN': dtype('float64'),
 'NU_NOTA_CH': dtype('float64'),
 'NU_NOTA_LC': dtype('float64'),
 'NU_NOTA_MT': dtype('float64'),
 'TX_RESPOSTAS_CN': dtype('O'),
 'TX_RESPOSTAS_CH': dtype('O'),
 'TX_RESPOSTAS_LC': dtype('O'),
 'TX_RESPOSTAS_MT': dtype('O'),
 'TP_LINGUA': dtype('int64'),
 'TX_GABARITO_CN': dtype('O'),
 'TX_GABARITO_CH': dtype('O'),
 'TX_GABARITO_LC': dtype('O'),
 'TX_GABARITO_MT': dtype('O'),
 'TP_STATUS_REDACAO': dtype('float64'),
 'NU_NOTA_COMP1': dtype('float64'),
 'NU_NOTA_COMP2': dtype('float64'),
 'NU_NOTA_COMP3': dtype('float64'),
 'NU_NOTA_COMP4': dtype('float64'),
 'NU_NOTA_COMP5': dtype('float64'),
 'NU_NOTA_REDACAO': dtype('float64'),
 'Q001': dtype('O'),
 'Q002': dtype('O'),
 'Q003': dtype('O'),
 'Q004': dtype('O'),
 'Q005': dtype('int64'),
 'Q006': dtype('O'),
 'Q007': dtype('O'),
 'Q008': dtype('O'),
 'Q009': dtype('O'),
 'Q010': dtype('O'),
 'Q011': dtype('O'),
 'Q012': dtype('O'),
 'Q013': dtype('O'),
 'Q014': dtype('O'),
 'Q015': dtype('O'),
 'Q016': dtype('O'),
 'Q017': dtype('O'),
 'Q018': dtype('O'),
 'Q019': dtype('O'),
 'Q020': dtype('O'),
 'Q021': dtype('O'),
 'Q022': dtype('O'),
 'Q023': dtype('O'),
 'Q024': dtype('O'),
 'Q025': dtype('O')}
In [7]:
#enemMG = enem.CO_REGIAO_CURSO == 31


enemMG = enem.loc[
    enem.CO_UF_RESIDENCIA == 31
]
In [8]:
enemMG
Out[8]:
NU_INSCRICAO	NU_ANO	CO_MUNICIPIO_RESIDENCIA	NO_MUNICIPIO_RESIDENCIA	CO_UF_RESIDENCIA	SG_UF_RESIDENCIA	NU_IDADE	TP_SEXO	TP_ESTADO_CIVIL	TP_COR_RACA	...	Q016	Q017	Q018	Q019	Q020	Q021	Q022	Q023	Q024	Q025
4	190001237802	2019	3118601	Contagem	31	MG	22.0	F	1	1	...	B	A	A	B	A	A	C	B	B	B
14	190001237803	2019	3170206	Uberl�ndia	31	MG	30.0	F	1	2	...	A	A	A	B	A	A	B	A	A	A
25	190001237804	2019	3124104	Esmeraldas	31	MG	27.0	M	1	3	...	A	A	A	B	A	B	C	A	A	A
32	190001237805	2019	3118304	Conselheiro Lafaiete	31	MG	22.0	F	1	1	...	B	A	B	C	B	A	E	A	B	B
38	190001237806	2019	3162922	S�o Joaquim de Bicas	31	MG	23.0	F	1	4	...	B	A	A	B	B	A	C	A	B	B
...	...	...	...	...	...	...	...	...	...	...	...	...	...	...	...	...	...	...	...	...	...
5095201	190005766803	2019	3171204	Vespasiano	31	MG	23.0	M	1	2	...	B	A	A	C	A	B	D	A	B	B
5095225	190005766804	2019	3170206	Uberl�ndia	31	MG	28.0	F	2	1	...	A	A	B	B	B	B	C	B	B	B
5095236	190005766805	2019	3162500	S�o Jo�o del Rei	31	MG	20.0	M	1	4	...	B	A	B	C	B	B	C	B	B	B
5095237	190005766806	2019	3158201	Santa Maria do Sua�u�	31	MG	18.0	F	1	3	...	A	A	A	B	A	A	B	A	A	A
5095256	190005766807	2019	3171303	Vi�osa	31	MG	29.0	F	1	3	...	A	A	A	B	A	A	B	A	A	A
538896 rows × 136 columns

Salvar um arquivo CSV com os dados já limpos em seu computador.
In [9]:
enemMG.to_csv('./enem2019/DADOS/MICRODADOS_ENEM_2019_MG.csv', sep = ";", 
                    decimal = "." )
In [12]:
enemTeste = pd.read_csv("./enem2019/DADOS/MICRODADOS_ENEM_2019_MG.csv", 
                    sep = ";", 
                    decimal = "." )
In [13]:
enemTeste
Out[13]:
Unnamed: 0	NU_INSCRICAO	NU_ANO	CO_MUNICIPIO_RESIDENCIA	NO_MUNICIPIO_RESIDENCIA	CO_UF_RESIDENCIA	SG_UF_RESIDENCIA	NU_IDADE	TP_SEXO	TP_ESTADO_CIVIL	...	Q016	Q017	Q018	Q019	Q020	Q021	Q022	Q023	Q024	Q025
0	4	190001237802	2019	3118601	Contagem	31	MG	22.0	F	1	...	B	A	A	B	A	A	C	B	B	B
1	14	190001237803	2019	3170206	Uberl�ndia	31	MG	30.0	F	1	...	A	A	A	B	A	A	B	A	A	A
2	25	190001237804	2019	3124104	Esmeraldas	31	MG	27.0	M	1	...	A	A	A	B	A	B	C	A	A	A
3	32	190001237805	2019	3118304	Conselheiro Lafaiete	31	MG	22.0	F	1	...	B	A	B	C	B	A	E	A	B	B
4	38	190001237806	2019	3162922	S�o Joaquim de Bicas	31	MG	23.0	F	1	...	B	A	A	B	B	A	C	A	B	B
...	...	...	...	...	...	...	...	...	...	...	...	...	...	...	...	...	...	...	...	...	...
538891	5095201	190005766803	2019	3171204	Vespasiano	31	MG	23.0	M	1	...	B	A	A	C	A	B	D	A	B	B
538892	5095225	190005766804	2019	3170206	Uberl�ndia	31	MG	28.0	F	2	...	A	A	B	B	B	B	C	B	B	B
538893	5095236	190005766805	2019	3162500	S�o Jo�o del Rei	31	MG	20.0	M	1	...	B	A	B	C	B	B	C	B	B	B
538894	5095237	190005766806	2019	3158201	Santa Maria do Sua�u�	31	MG	18.0	F	1	...	A	A	A	B	A	A	B	A	A	A
538895	5095256	190005766807	2019	3171303	Vi�osa	31	MG	29.0	F	1	...	A	A	A	B	A	A	B	A	A	A
538896 rows × 137 columns

Escrever os dados numa tabela relacional em uma base de dados de sua escolha (MySQL, PostgreSQL, SQL Server etc.).
In [26]:
!pip install pyodbc
Requirement already satisfied: pyodbc in c:\users\nobre\anaconda3\lib\site-packages (4.0.0-unsupported)
In [34]:
!pip install sqlalchemy
Requirement already satisfied: sqlalchemy in c:\users\nobre\anaconda3\lib\site-packages (1.4.7)
Requirement already satisfied: greenlet!=0.4.17 in c:\users\nobre\anaconda3\lib\site-packages (from sqlalchemy) (1.0.0)
In [27]:
# Ingestão no SQL Server

import pyodbc
import sqlalchemy
In [79]:
engine = sqlalchemy.create_engine(
    "mssql+pyodbc://luciana:luciana@NOBRE\SQLEXPRESS/enemMG?driver=ODBC+Driver+17+for+SQL+Server"
)
In [81]:
#conexão utilizada
engine = sqlalchemy.create_engine(
    "mssql+pyodbc://NOBRE\SQLEXPRESS/enemMG?trusted_connection=yes&driver=ODBC+Driver+13+for+SQL+Server'"
)
In [88]:
'''
from sqlalchemy import create_engine

server = 'NOBRE\SQLEXPRESS'

database = 'enemMG'

engine = create_engine('mssql+pyodbc://' + server + '/' + database + '?trusted_connection=yes&driver=ODBC+Driver+13+for+SQL+Server')
'''
In [89]:
#Importa os dados do DF para o DB
enemMG.to_sql("enemMG", con=engine, index=False, if_exists='append')
Trabalho Prático - Questões
1. Qual é a média da nota em matemática de todos os alunos mineiros?
Comando SQL:

SELECT avg (NU_NOTA_MT) as [Nota média Matemática] FROM enemMG

In [104]:
enemMG.NU_NOTA_MT.describe()
Out[104]:
count    393872.000000
mean        546.796208
std         115.072018
min           0.000000
25%         451.800000
50%         531.400000
75%         629.800000
max         985.500000
Name: NU_NOTA_MT, dtype: float64
Resposta: 546.8
2. Qual é a média da nota em Linguagens e Códigos de todos os alunos mineiros?
Comando SQL:

SELECT avg (NU_NOTA_LC) as [Nota média de Linguagens e Códigos] FROM enemMG

In [91]:
enemMG.NU_NOTA_LC.describe()
Out[91]:
count    414346.000000
mean        531.215550
std          61.324732
min           0.000000
25%         497.400000
50%         536.500000
75%         572.900000
max         770.500000
Name: NU_NOTA_LC, dtype: float64
Resposta: 531.2
3. Qual é a média da nota em Ciências Humanas dos alunos do sexo FEMININO mineiros?
Comando SQL:

SELECT avg (NU_NOTA_CH) as [Nota média de Ciências Humanas e do sexo Feminino] FROM enemMG WHERE TP_SEXO LIKE 'F'

In [101]:
enemMG.loc[enemMG.TP_SEXO=='F'].NU_NOTA_CH.describe()
Out[101]:
count    251816.000000
mean        515.127098
std          81.019828
min           0.000000
25%         458.200000
50%         519.300000
75%         572.600000
max         795.000000
Name: NU_NOTA_CH, dtype: float64
Resposta: 515.1
4. Qual é a média da nota em Ciências Humanas dos alunos do sexo MASCULINO?
Comando SQL:

SELECT avg (NU_NOTA_CH) as [Nota média de Ciências Humanas e do sexo Masculino] FROM enemMG WHERE TP_SEXO LIKE 'M'

In [102]:
enemMG.loc[enemMG.TP_SEXO=='M'].NU_NOTA_CH.describe()
Out[102]:
count    162530.000000
mean        529.698270
std          85.803672
min           0.000000
25%         470.200000
50%         538.500000
75%         591.500000
max         835.100000
Name: NU_NOTA_CH, dtype: float64
Resposta: 529.7
5. Qual é a média da nota em Matemática dos alunos do sexo FEMININO que moram na cidade de Montes Claros?
Comando SQL:

SELECT avg (NU_NOTA_MT) as [Nota média Matemática / Feminino / Montes Claros] FROM enemMG WHERE TP_SEXO LIKE 'F' and NO_MUNICIPIO_RESIDENCIA LIKE 'Montes Claros'

In [103]:
enemMG.loc[(enemMG.TP_SEXO=='F') & (enemMG.NO_MUNICIPIO_RESIDENCIA=='Montes Claros')].NU_NOTA_MT.describe()
Out[103]:
count    7699.000000
mean      525.477672
std       107.081759
min       359.300000
25%       438.750000
50%       505.400000
75%       601.000000
max       913.700000
Name: NU_NOTA_MT, dtype: float64
Resposta: 525.5
6. Qual é a média da nota em Matemática dos alunos do município de Sabará que possuem TV por assinatura na residência?
Comando SQL:

SELECT avg (NU_NOTA_MT) as [Nota média Matemática / TV assinatura / Sabará] FROM enemMG WHERE Q021 LIKE 'B' and NO_MUNICIPIO_RESIDENCIA LIKE 'Sabar%'

In [105]:
enemMG.loc[(enemMG.CO_MUNICIPIO_RESIDENCIA==3156700) & (enemMG.Q021=='B')].NU_NOTA_MT.describe()
Out[105]:
count    704.000000
mean     543.292756
std      115.270483
min      359.100000
25%      444.125000
50%      521.850000
75%      622.425000
max      924.700000
Name: NU_NOTA_MT, dtype: float64
Resposta: 543.3
7. Qual é a média da nota em Ciências Humanas dos alunos mineiros que possuem dois fornos micro-ondas em casa?
Comando SQL:

SELECT avg (NU_NOTA_CH) as [Nota média de Ciências Humana / +2 Fornos] FROM enemMG WHERE Q016 LIKE 'C'

In [107]:
enemMG.loc[enemMG.Q016=='C'].NU_NOTA_CH.describe()
Out[107]:
count    2205.000000
mean      557.276599
std        90.127265
min         0.000000
25%       498.000000
50%       572.500000
75%       622.200000
max       775.500000
Name: NU_NOTA_CH, dtype: float64
Resposta: 557.3
8. Qual é a nota média em Matemática dos alunos mineiros cuja mãe completou a pós-graduação?
Comando SQL:

SELECT avg (NU_NOTA_MT) as [Nota média Matemática / Mãe com Pós] FROM enemMG WHERE Q002 LIKE 'g'

In [108]:
enemMG.loc[enemMG.Q002=='G'].NU_NOTA_MT.describe()
Out[108]:
count    40937.000000
mean       620.007062
std        122.608027
min          0.000000
25%        525.600000
50%        629.200000
75%        710.200000
max        985.500000
Name: NU_NOTA_MT, dtype: float64
Resposta: 620.0
9. Qual é a nota média em Matemática dos alunos de Belo Horizonte e de Conselheiro Lafaiete?
Comando SQL:

ELECT avg (NU_NOTA_MT) as [Nota média Matemática / BH e CL] FROM enemMG WHERE NO_MUNICIPIO_RESIDENCIA in ( 'Conselheiro Lafaiete', 'Belo Horizonte' )

In [112]:
enemMG.loc[(enemMG.NO_MUNICIPIO_RESIDENCIA=='Belo Horizonte') | (enemMG.NO_MUNICIPIO_RESIDENCIA=='Conselheiro Lafaiete')].NU_NOTA_MT.describe()
Out[112]:
count    59238.000000
mean       578.039227
std        128.510689
min          0.000000
25%        469.700000
50%        570.500000
75%        674.200000
max        985.500000
Name: NU_NOTA_MT, dtype: float64
Resposta: 578.0
10. Qual é a nota média em Ciências Humanas dos alunos mineiros que moram sozinhos?
Comando SQL:

SELECT avg (NU_NOTA_CH) as [Nota média de Ciências Humana / Moram Só] FROM enemMG WHERE Q005 LIKE '1'

In [113]:
enemMG.loc[enemMG.Q005==1].NU_NOTA_CH.describe()
Out[113]:
count    10131.000000
mean       534.457339
std         86.729627
min          0.000000
25%        478.950000
50%        543.200000
75%        595.300000
max        786.600000
Name: NU_NOTA_CH, dtype: float64
Resposta: 534.5
11. Qual é a nota média em Ciências Humanas dos alunos mineiros cujo pai completou pós-graduação e possuem renda familiar entre R$ 8.982,01 e R$ 9.980,00.
Comando SQL:

SELECT avg (NU_NOTA_CH) as [Nota média de Ciências Humana / Etc] FROM enemMG WHERE Q001 LIKE 'G' and Q006 LIKE 'M'

In [114]:
enemMG.loc[(enemMG.Q001=='G') & (enemMG.Q006=='M')].NU_NOTA_CH.describe()
Out[114]:
count    1118.000000
mean      586.723166
std        75.330683
min       319.300000
25%       550.425000
50%       598.450000
75%       637.525000
max       784.000000
Name: NU_NOTA_CH, dtype: float64
Resposta: 586.7
12. Qual é a nota média em Matemática dos alunos do sexo Feminino que moram em Lavras e escolheram “Espanhol” como língua estrangeira?
Comando SQL:

SELECT avg (NU_NOTA_MT) as [Nota média Matemática / Feminino / Lavras / Espanhol] FROM enemMG WHERE TP_SEXO LIKE 'F'and NO_MUNICIPIO_RESIDENCIA LIKE 'Lavras' and TP_LINGUA LIKE '1'

In [119]:
enemMG.loc[(enemMG.TP_SEXO=='F') & (enemMG.NO_MUNICIPIO_RESIDENCIA=='Lavras') & (enemMG.TP_LINGUA==1)].NU_NOTA_MT.describe()
Out[119]:
count    894.000000
mean     510.809508
std       94.541685
min      359.900000
25%      435.175000
50%      492.200000
75%      570.350000
max      870.200000
Name: NU_NOTA_MT, dtype: float64
Resposta: 510.8
13. Qual é a nota média em Matemática dos alunos do sexo Masculino que moram em Ouro Preto?
Comando SQL:

SELECT avg (NU_NOTA_MT) as [Nota média Matemática / Masculino / Ouro Preto] FROM enemMG WHERE TP_SEXO LIKE 'M'and NO_MUNICIPIO_RESIDENCIA LIKE 'Ouro Preto'

In [121]:
enemMG.loc[(enemMG.TP_SEXO=='M') & (enemMG.NO_MUNICIPIO_RESIDENCIA=='Ouro Preto')].NU_NOTA_MT.describe()
Out[121]:
count    1230.000000
mean      555.083252
std       114.936273
min       359.000000
25%       461.250000
50%       540.500000
75%       638.650000
max       903.900000
Name: NU_NOTA_MT, dtype: float64
Resposta: 555.1
14. Qual é a nota média em Ciências Humanas dos alunos surdos?
Comando SQL:

SELECT avg (NU_NOTA_CH) as [Nota média de Ciências Humana / Surdez] FROM enemMG WHERE IN_SURDEZ LIKE '1'

In [122]:
enemMG.loc[enemMG.IN_SURDEZ==1].NU_NOTA_CH.describe()
Out[122]:
count    108.000000
mean     435.387963
std       61.942581
min      330.500000
25%      395.100000
50%      426.350000
75%      471.250000
max      616.500000
Name: NU_NOTA_CH, dtype: float64
Resposta: 435.4
15. Qual é a nota média em Matemática dos alunos do sexo FEMININO, que moram em Belo Horizonte, Sabará, Nova Lima e Betim e possuem dislexia?
Comando SQL:

SELECT avg (NU_NOTA_MT) as [Nota média Matemática / Etc] FROM enemMG WHERE NO_MUNICIPIO_RESIDENCIA in ( 'Betim', 'Belo Horizonte', 'Sabar%', 'Nova Lima' ) and TP_SEXO LIKE 'F' and IN_DISLEXIA LIKE '1'

In [123]:
enemMG.loc[((enemMG.CO_MUNICIPIO_RESIDENCIA==3156700) | (enemMG.NO_MUNICIPIO_RESIDENCIA=='Belo Horizonte') | (enemMG.NO_MUNICIPIO_RESIDENCIA=='Nova Lima') | (enemMG.NO_MUNICIPIO_RESIDENCIA=='Betim')) & (enemMG.TP_SEXO=='F') & (enemMG.IN_DISLEXIA==1)].NU_NOTA_MT.describe()
Out[123]:
count     31.000000
mean     582.193548
std      131.003641
min      363.600000
25%      474.250000
50%      604.400000
75%      672.750000
max      789.100000
Name: NU_NOTA_MT, dtype: float64
Resposta: 582.2