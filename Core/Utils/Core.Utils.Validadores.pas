unit Core.Utils.Validadores;

interface

type
  TValidadores = class

  public
    class function ValidarUF(const AUF: string): Boolean;
    class function ValidarCEP(const ACEP: string): Boolean;
    class function ValidarCNPJ(const ACNPJ: string): Boolean;
    class function ValidarCPF(const ACPF: string): Boolean;
    class function ValidarTelefone(const ATelefone: string): Boolean;
    class function ValidarEmail(const AEmail: string): Boolean;

  end;

implementation

uses System.SysUtils, System.RegularExpressions;

{ TValidadores }

class function TValidadores.ValidarUF(const AUF: string): Boolean;
const UF_VALIDAS: array[0..26] of string = (
    'AC','AL','AP','AM','BA','CE','DF','ES','GO','MA','MT',
    'MS','MG','PA','PB','PR','PE','PI','RJ','RN','RS','RO',
    'RR','SC','SP','SE','TO' );
var I: Integer;
    UFUpper: string;
begin
  if AUF.Trim = '' then
    Exit(False);

  UFUpper := AUF.ToUpper.Trim;
  for I := Low(UF_VALIDAS) to High(UF_VALIDAS) do
  begin
    if UF_VALIDAS[I] = UFUpper then
      Exit(True);
  end;

  Result := False;
end;

class function TValidadores.ValidarCEP(const ACEP: string): Boolean;
const CEP_REGEX = '^\d{5}-\d{3}$';
begin
  Result := (FCEP = '') or TRegEx.IsMatch(FCEP, CEP_REGEX);
end;

class function TValidadores.ValidarCNPJ(const ACNPJ: string): Boolean;
const CNPJ_REGEX = '^\d{2}\.\d{3}\.\d{3}/\d{4}-\d{2}$';
begin
  Result := (FCNPJ = '') or TRegEx.IsMatch(FCNPJ, CNPJ_REGEX);
end;

class function TValidadores.ValidarCPF(const ACPF: string): Boolean;
const CPF_REGEX = '^\d{3}\.\d{3}\.\d{3}-\d{2}$';
begin
  Result := (FCPF = '') or TRegEx.IsMatch(FCPF, CPF_REGEX);
end;

class function TValidadores.ValidarEmail(const AEmail: string): Boolean;
const EMAIL_REGEX = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
begin
  Result := (FEmail = '') or TRegEx.IsMatch(FEmail, EMAIL_REGEX);
end;

class function TValidadores.ValidarTelefone(const ATelefone: string): Boolean;
const TELEFONE_REGEX = '^\(?\d{2}\)?[\s-]?\d{4,5}-?\d{4}$';
begin
  Result := (FTelefone = '') or TRegEx.IsMatch(FTelefone, TELEFONE_REGEX);
end;

end.
