# powerSqlmap
PoWerSqlmap O PoWerSqlmap éInjeção de SQL (SQLi)em URLs de vocêwaybackurls, `htthttpx, sqlmapeGF (GfPatterns) , o script identificado  Ele começa verificando se o usuário está conectado à internet, coletando URLs históricas de um domínio usando waybackurls, ehttpx. Usando sqlmap .  Este script é útil para pentesters, pesquisadores de segurança!

# PoWerSqlmap

O **PoWerSqlmap** é um script automatizado para identificar vulnerabilidades de SQL Injection (SQLi) em URLs de um domínio. Ele usa uma combinação de ferramentas como `waybackurls`, `httpx`, `sqlmap`, e padrões do GF (GfPatterns) para buscar, filtrar e testar automaticamente URLs vulneráveis a SQL Injection.

## Funcionalidades

- **Verificação de Conexão com a Internet**: O script verifica se o usuário está conectado à internet antes de iniciar o processo.
- **Busca de URLs Históricas**: Usa a ferramenta `waybackurls` para buscar URLs de um domínio e filtra as URLs com extensões específicas.
- **Verificação de URLs com `httpx`**: As URLs filtradas são verificadas com `httpx` para garantir que estejam ativas.
- **Detecção de Parâmetros Suspeitos**: O script usa os padrões do GF (GfPatterns) para identificar URLs que podem estar vulneráveis a SQL Injection, procurando por parâmetros de consulta.
- **Execução do SQLMap**: O script executa o `sqlmap` nas URLs identificadas como vulneráveis para realizar o teste de SQL Injection.

## Pré-requisitos

Antes de executar o script, verifique se você tem as seguintes ferramentas instaladas:

- [wget](https://www.gnu.org/software/wget/)
- [waybackurls](https://github.com/tomnomnom/waybackurls)
- [httpx](https://github.com/projectdiscovery/httpx)
- [sqlmap](https://github.com/sqlmapproject/sqlmap)
- [gf](https://github.com/tomnomnom/gf) (para os padrões GF)
- [lolcat](https://github.com/matrix1001/lolcat) (opcional, para mensagens engraçadas)

Você pode instalar as ferramentas usando os seguintes comandos:

```bash
sudo apt install wget
go install github.com/tomnomnom/waybackurls@latest
go install github.com/projectdiscovery/httpx/cmd/httpx@latest
git clone --depth 1 https://github.com/sqlmapproject/sqlmap.git sqlmap-dev
go install github.com/tomnomnom/gf@latest
sudo apt install lolcat
