unit cliente.model;

interface

uses System.SysUtils, FireDAC.Comp.Client, FireDAC.DApt;

type
  TCliente = class

  private
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

    procedure SetDes_RazaoSOcial(const Value: string);

  public
    property Cod_Cliente: Integer read FCod_Cliente write FCod_Cliente;
    property Des_RazaoSocial: string read FDes_RazaoSocial write SetDes_RazaoSocial;
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

procedure TCliente.SetDes_RazaoSocial(const Value: string);
begin
  if Value = EmptyStr then
    raise EArgumentException.Create('O campo ''Raz�o Social'' precisa ser preenchido !');

  FDes_RazaoSocial := Value;
end;

end.
