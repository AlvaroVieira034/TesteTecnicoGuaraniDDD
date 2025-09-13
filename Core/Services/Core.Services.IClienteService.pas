unit Core.Services.IClienteService;

interface

uses
  System.SysUtils, System.Generics.Collections, System.Classes,
  Core.Entities.Cliente, Data.DB, FireDAC.Comp.Client;

type
  IClienteService = interface
    ['{9EFCC396-E956-484A-B5F3-0328A109E66B}']

    // Métodos de Consulta
    procedure PreencherGridForm(APesquisa, ACampo: string);
    procedure PreencherComboBox(TblClientes: TFDQuery);
    procedure PreencherCamposForm(ACliente: TCliente; AId: Integer);
    function BuscarClientePorCodigo(AId: Integer): TCliente;
    procedure ValidarCliente(ACliente: TCliente);

    // Metodos para criação de tabeas
    procedure CriarTabelas;
    function GetDataSource: TDataSource;

  end;

implementation


end.
