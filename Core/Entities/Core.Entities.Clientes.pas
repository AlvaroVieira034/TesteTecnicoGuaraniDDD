unit Core.Entities.Clientes;

interface

uses System.SysUtils, System.RegularExpressions, Core.ValueObjects.Endereco, Core.ValueObjects.Contato,
     Core.ValueObjects.Documento;

type
  EClienteException = class(Exception);

  TCliente = class

  private
    FId: Integer;
    FRazaoSocial: string;
    FNomeFantasia: string;
    FEndereco: TEndereco;
    FContato: TContato;
    FDocuemtno: TDocumento;
    FAtivo: Boolean;
    FDocumento: TDocumento;

    procedure ValidarRazaoSocial(const ARazaoSocial: string);
    procedure ValidarDados;

  public
    constructor Create; overload;
    constructor Create(const ARazaoSocial: string); overload;
    destructor Destroy; override;

    procedure Ativar;
    procedure Desativar;
    procedure AlterarDados(const ARazaoSocial, ANomeFantasia: string);
    procedure DefinirEndereco(const ACEP, ALogradouro, AComplemento, ACidade, AUF);
    procedure DefinirContato(const ATelefone: string);
    procedure DefinirDocumento(const ACNPJ: string);

    function ValidarCNPJ: Boolean;
    function ValidarTelefone: Boolean;
    function ValidarCep: Boolean;

    property Id: Integer read FId write FId;
    property RazaoSocial: string read FRazaoSocial;
    property NomeFantasia: string read FNomeFantasia;
    property Endereco: TEndereco read FEndereco;
    property Contato: TContato read FContato;
    property Documento: TDocumento read FDocumento;
    property Ativo: Boolean read FAtivo;

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
   FRazaoSocial := ARazaoSocial;
end;

destructor TCliente.Destroy;
begin

  inherited;
end;

procedure TCliente.Ativar;
begin

end;

procedure TCliente.Desativar;
begin

end;

procedure TCliente.AlterarDados(const ARazaoSocial, ANomeFantasia: string);
begin

end;

procedure TCliente.DefinirEndereco(const ACEP, ALogradouro, AComplemento, ACidade, AUF);
begin

end;

procedure TCliente.DefinirContato(const ATelefone: string);
begin

end;

procedure TCliente.DefinirDocumento(const ACNPJ: string);
begin

end;

function TCliente.ValidarCNPJ: Boolean;
begin

end;

function TCliente.ValidarTelefone: Boolean;
begin

end;

function TCliente.ValidarCep: Boolean;
begin

end;

procedure TCliente.ValidarRazaoSocial(const ARazaoSocial: string);
begin
  if ARazaoSocial.Trim = '' then
    raise EClienteException.Create('A razão social deve ser preenchida!');

  if Length(ARazaoSocial) < 3 then
    raise EClienteException.Create('A razão social deve ter pelo menos 3 caracteres!);



end;

procedure TCliente.ValidarDados;
begin

end;



end.
