unit Core.ValueObjects.Endereco;

interface

type
  TEndereco = class

  private
    FCEP: string;
    FLogradouro: string;
    FNumero: string;
    FComplemento: string;
    FBairro: string;
    FCidade: string;
    FUF: string;

  public
    function ValidarCEP: Boolean;
    function ValidarUF: Boolean;
    function ToString: string;
    function EstaVazio: Boolean;

    property CEP: string read FCEP write FCEP;
    property Logradouro: string read FLogradouro write FLogradouro;
    property Numero: string read FNumero write FNumero;
    property Complemento: string read FComplemento write FComplemento;
    property Bairro: string read FBairro write FBairro;
    property Cidade: string read FCidade write FCidade;
    property UF: string read FUF write FUF;

  end;

implementation

uses System.SysUtils, System.RegularExpressions, Core.Utils.Validadores;

{ TEndereco }

function TEndereco.ValidarCEP: Boolean;
begin
  Result := (FCEP = '') or TValidadores.ValidarCEP(FCEP);
end;

function TEndereco.ValidarUF: Boolean;
begin
  Result := (FUF = '') or TValidadores.ValidarUF(FUF);
end;

function TEndereco.ToString: string;
begin
  Result := Format('%s, %s - %s - %s - %s', [FLogradouro, FNumero, FComplemento, FCidade, FUF]);
end;

function TEndereco.EstaVazio: Boolean;
begin
  Result := (FCEP = '') and (FLogradouro = '') and (FCidade = '') and (FUF = '');
end;


end.
