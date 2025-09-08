unit Core.ValueObjects.Documento;

interface

type
  TDocumento = class
  private
    FCNPJ: string;
    FCPF: string;
  public
    function ValidarCNPJ: Boolean;
    function ValidarCPF: Boolean;
    function LimparFormatacao(const AValor: string): string;

    property CNPJ: string read FCNPJ write FCNPJ;
    property CPF: string read FCPF write FCPF;
  end;

implementation

uses System.SysUtils, System.RegularExpressions, Core.Utils.Validadores;

{ TDocumento }

function TDocumento.ValidarCNPJ: Boolean;
begin
  Result := (FCNPJ = '') or TValidadores.ValidarCNPJ(FCNPJ);
end;

function TDocumento.ValidarCPF: Boolean;
begin
  Result := (FCPF = '') or TValidadores.ValidarCPF(FCPF);
end;

function TDocumento.LimparFormatacao(const AValor: string): string;
begin
  Result := AValor.Replace('.', '').Replace('-', '').Replace('/', '');
end;

end.



