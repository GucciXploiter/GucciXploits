from json import loads
from os import system,name
from time import sleep
from urllib.request import Request

global R,B,C,G
R='\033[1;31m';B='\033[1;34m';C='\033[1;37m';G='\033[1;32m'


try:
	from requests import get
except:
	try:
		from sys import executable
		system(executable+' -m pip install requests')
		from requests import get
	except:
		print('%s[ %s!%s ] Instale manualmente o(s) módulo(s) requests.'%(C,R,C));exit()
		
try:
	ipmenu=get('https://ipwhois.app/json/').text
	ipmenu=loads(ipmenu)
	ipmenu=ipmenu['ip']
except:
	print('%s[%s ! %s] Verifique sua conexão à Internet! \n%s'%(C,R,C))
	exit()


api={
'1':'https://brasilapi.com.br/api/ddd/v1/​',
'2':'https://www.receitaws.com.br/v1/cnpj/',
'3':'https://viacep.com.br/ws/',
'4':'https://ipwhois.app/json/',
'5':'https://brasilapi.com.br/api/banks/v1/',

}


logo='''   ____                         _   ____            _                  _    __  __
  / ___|  _   _    ___    ___  (_) |  _ \    __ _  (_)  _ __     ___  | |   \ \/ /
 | |  _  | | | |  / __|  / __| | | | |_) |  / _` | | | | '_ \   / _ \ | |    \  / 
 | |_| | | |_| | | (__  | (__  | | |  __/  | (_| | | | | | | | |  __/ | |    /  \ 
  \____|  \__,_|  \___|  \___| |_| |_|      \__,_| |_| |_| |_|  \___| |_|   /_/\_\ \n'''



def req(api_req) -> str: return loads(get(api_req).text)
def clear(clean) -> None: return system(clean)



def ip() -> str:
	api_req=api['4']+input('%s%s%s\n%s>%s Digite o Endereço de IP que deseja buscar : '%(B,logo,C,G,C))
	result=req(api_req)
	try:
		return '[%s IP %s: %s ]\n[%s Tipo %s: %s ]\n[%s Continente%s: %s ]\n[%s País %s: %s ]\n[%s Capital %s: %s ]\n[%s Região %s: %s ]\n[%s Cidade %s: %s ]\n[%s DDI %s: %s ]\n[%s Latitude %s: %s ]\n[ %sLongitude%s : %s ]'%(G,C,result['ip'],G,C,result['type'],G,C,result['continent'],G,C,result['country'],G,C,result['country_capital'],G,C,result['region'],G,C,result['city'],G,C,result['country_phone'],G,C,result['latitude'],G,C,result['longitude'])
	except:
		return '%s[ %s!%s ] Endereço de IP não encontrado.'%(C,R,C)
def ddd() -> str:
	api_req=req('https://brasilapi.com.br/api/ddd/v1/%s'%input('%s%s%s\n%s>%s Digite o DDD : '%(G,logo,C,G,C)))
	clear(clean)
	try:
		msg='%s%s%s[ %sEstado%s: %s ]\n[ %sCidades%s:'%(B,logo,C,G,C,api_req['state'],G,C)
		for i in api_req['cities']: msg+=str(' '+G+i+','+C)
		return msg
	except Exception:
		return '[ %s!%s ] DDD não Encontrado.'%(R,C)

def placa() -> str:
	result=loads(get('https://apicarros.com/v2/consultas/%s/f63e1e63dd231083d38ce929984aac7d'%input('%s%s%s\n%s>%s Digite a Placa : '%(G,logo,C,G,C)),verify=False).text)
	msg='%s%s%s\n'%(B,logo,C)
	clear(clean)
	for i in result:
		msg+=str('[ '+G+str(i.upper())+C+ ' : ' + str(result[i]) + ' ]\n').replace('{','\n')
	return msg


def cep() -> str:
	try:
		result=req(api['3']+input('%s%s%s\n%s>%s Digite o CEP : '%(B,logo,C,G,C))+'/json')
		return '[ %sCEP%s : %s ]\n[ %sLogradouro%s : %s]\n[ %sComplemento%s : %s ]\n[ %sBairro%s : %s]\n[ %sLocalidade%s : %s]\n[ %sEstado(UF)%s : %s]\n[ %sIBGE%s : %s]\n[ %sGIA%s : %s]\n[ %sDDD%s : %s]\n[ %sSIAFI%s : %s]'%(G,C,result['cep'],G,C,result['logradouro'],G,C,result['complemento'],G,C,result['bairro'],G,C,result['localidade'],G,C,result['uf'],G,C,result['ibge'],G,C,result['gia'],G,C,result['ddd'],G,C,result['siafi'])
	except:
		error ='[ %s!%s ] CEP Inválido.'%(R,C)
		return error

	

def cnpj() -> str:
	result=req('https://www.receitaws.com.br/v1/cnpj/%s'%input('%s%s%s\n%s>%s Digite o CNPJ : '%(G,logo,C,G,C)))
	msg=''
	for i in result:
		msg+=str('[ '+G+str(i.upper())+C+ ' : ' + str(result[i]) + ' ]\n')
	return msg





def exit() -> None:
	global Exit
	Exit=True

def show_api() -> str:
	msg=''
	for i in api: i='%s{%s '%(B,C)+api[i]+' %s}%s\n'%(B,C);msg+=i
	input('%s%s%s\n === Lista de APIs ===\n%s%s>%s APERTE ENTER PARA VOLTAR AO MENU %s<%s'%(B,logo,C,msg,G,C,G,C))

Exit=False

MatchCase={
'1':ddd,
'2':cnpj,
'3':cep,
'4':ip,
'5':placa,
}

MatchCase_Function={
'99':show_api,
'00':exit
}

def menu() -> None:
	while Exit==False:
		clear(clean)
		option=str(input('''%s%s%s
Bem-Vindo(a) ao %sGucciPainel X |Free|%s

Seu Endereço de IP [%s%s%s]

[%s%sAdicionado : %sCrowns Duplicator for stumble Guys%s]
[Discord : %sGucci#2661%s | TikTok : %s@gucci..mp4%s]


|================================|
|[ %s1%s ] Consulta de DDD     [%sON%s]  |
|[ %s2%s ] Consulta de CNPJ    [%sON%s]  |
|[ %s3%s ] Consulta de CEP     [%sON%s]  |
|[ %s4%s ] Consulta de IP      [%sON%s]  |
|[ %s5%s ] Consulta de Placa   [%sON%s]  |%s%s
|================================|
|[ %s99%s ] Apis                     |
|[ %s00%s ] Sair                     |
|================================|
[ ! ] > %s'''%(G,logo,C,B,C,B,ipmenu,C,C,C,B,C,B,C,B,C,B,C,G,C,B,C,G,C,B,C,G,C,B,C,G,C,B,C,G,C,B,C,B,C,R,C,G)))
		clear(clean)
		try:
			res='%s\n%s'%(MatchCase[option](),'%s>%s Aperte Enter para retornar ao menu %s<%s'%(G,C,G,C))
			input(res)
		except Exception:
			try:
				MatchCase_Function[option]()
			except:
				pass
if __name__=='__main__':
	global clean
	clean ={'nt':'cls','posix':'clear'}[name]
	menu()
