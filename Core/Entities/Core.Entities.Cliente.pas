unit Core.Entities.Cliente;

interface

uses System.SysUtils, System.RegularExpressions, Core.ValueObjects.Endereco, Core.ValueObjects.Contato,
     Core.ValueObjects.Documento;

type
  EClienteException = class(Exception);

  TCliente = class

  private
    FAtivo: Boolean;
    FCod_Cliente: Integer;
    FDes_RazaoSocial: string;
    FDes_NomeFantasia: string;
    FDes_Cep: string;
    FDes_Endereco: string;
    FDes_Complemento: string;
    FDes_Cidade: string;
    FDes_UF: string;
    FDes_Cnpj: string;
    FDes_Telefone: string;

    FEndereco: TEndereco;
    FContato: TContato;
    FDocumento: TDocumento;

    procedure ValidarRazaoSocial(const ARazaoSocial: string);

  public
    constructor Create; overload;
    constructor Create(const ARazaoSocial: string); overload;
    destructor Destroy; override;

    procedure Ativar;
    procedure Desativar;
    procedure AlterarDados(const ARazaoSocial, ANomeFantasia: string);
    procedure DefinirEndereco(const ACEP, ALogradouro, AComplemento, ACidade, AUF: string);
    procedure DefinirContato(const ATelefone: string);
    procedure DefinirDocumento(const ACNPJ: string);

    procedure ValidarDados;
    function ValidarCNPJ: Boolean;
    function ValidarTelefone: Boolean;
    function ValidarCep: Boolean;

    property Ativo: Boolean read FAtivo write FAtivo;
    property Cod_Cliente: Integer read FCod_Cliente write FCod_Cliente;
    property Des_RazaoSocial: string read FDes_RazaoSocial write FDes_RazaoSocial;
    property Des_NomeFantasia: string read FDes_NomeFantasia write FDes_NomeFantasia;
    property Des_Cep: string read FDes_Cep write FDes_Cep;
    property Des_Endereco: string read FDes_Endereco write FDes_Endereco;
    property Des_Complemento: string read FDes_Complemento write FDes_Complemento;
    property Des_Cidade: string read FDes_Cidade write FDes_Cidade;
    property Des_UF: string read FDes_UF write FDes_UF;
    property Des_Cnpj: string read FDes_Cnpj write FDes_Cnpj;
    property Des_Telefone: string read FDes_Telefone write FDes_Telefone;

  end;

implementation

{ TCliente }

constructor TCliente.Create;
begin
  inherited Create;
  FEndereco := TEndereco.Create;
  FContato := TContato.Create;
  FDocumento := TDocumento.Create;
  FAtivo := True;
end;

constructor TCliente.Create(const ARazaoSocial: string);
begin
   Create;
   FDes_RazaoSocial := ARazaoSocial;
end;

destructor TCliente.Destroy;
begin
  FEndereco.Free;
  FContato.Free;
  FDocumento.Free;

  inherited Destroy;
end;

procedure TCliente.Ativar;
begin
  FAtivo := True;
end;

procedure TCliente.Desativar;
begin
  FAtivo := False;
end;

procedure TCliente.AlterarDados(const ARazaoSocial, ANomeFantasia: string);
begin
  ValidarRazaoSocial(ARazaoSocial);

  FDes_RazaoSocial := ARazaoSocial;
  FDes_NomeFantasia := ANomeFantasia;
  ValidarDados;
end;

procedure TCliente.DefinirEndereco(const ACEP, ALogradouro, AComplemento, ACidade, AUF: string);
begin
  FEndereco.CEP := ACEP;
  FEndereco.Logradouro := ALogradouro;
  FEndereco.Complemento := AComplemento;
  FEndereco.Cidade := ACidade;
  FEndereco.UF := AUF;
  ValidarDados;
end;

procedure TCliente.DefinirContato(const ATelefone: string);
begin
  FContato.Telefone := ATelefone;
  ValidarDados;
end;

procedure TCliente.DefinirDocumento(const ACNPJ: string);
begin
  FDocumento.CNPJ := ACNPJ;
  ValidarDados;
end;

procedure TCliente.ValidarDados;
begin
  ValidarRazaoSocial(FDes_RazaoSocial);

  if FEndereco.Cidade.Trim = '' then
    raise EClienteException.Create('Cidade é obrigatória');

  if FEndereco.UF.Trim = '' then
    raise EClienteException.Create('UF é obrigatória');

  if not ValidarCNPJ then
    raise EClienteException.Create('CNPJ inválido');
end;

function TCliente.ValidarCNPJ: Boolean;
begin
  Result := FDocumento.ValidarCNPJ;
end;

function TCliente.ValidarTelefone: Boolean;
begin
  Result := FContato.ValidarTelefone;
end;

function TCliente.ValidarCep: Boolean;
begin
  Result := FEndereco.ValidarCEP;
end;

procedure TCliente.ValidarRazaoSocial(const ARazaoSocial: string);
begin
  if ARazaoSocial.Trim = '' then
    raise EClienteException.Create('A razão social deve ser preenchida!');

  if Length(ARazaoSocial) < 3 then
    raise EClienteException.Create('A razão social deve ter pelo menos 3 caracteres!');

end;


end.
