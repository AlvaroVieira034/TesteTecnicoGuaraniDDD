unit Core.ValueObjects.Contato;

interface

type
  TContato = class

  private
    FTelefone: string;
    FEmail: string;

  public
    function ValidarTelefone: Boolean;
    function ValidarEmail: Boolean;

    property Telefone: string read FTelefone write FTelefone;
    property Email: string read FEmail write FEmail;
  end;

implementation

uses System.SysUtils, System.RegularExpressions, Core.Utils.Validadores;

{ TContato }

function TContato.ValidarTelefone: Boolean;
begin
  Result := (FTelefone = '') or TValidadores.ValidarTelefone(FTelefone);
end;

function TContato.ValidarEmail: Boolean;
begin
  Result := (FEmail = '') or TValidadores.ValidarEmail(FEmail);
end;

end.
