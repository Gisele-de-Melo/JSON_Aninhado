//------------------------------------------------------------------------------------------------------------
//********* Sobre ************
//Autor: Gisele de Melo
//Esse código foi desenvolvido com o intuito de aprendizado para o blog codedelphi.com, portanto não me
//responsabilizo pelo uso do mesmo.
//
//********* About ************
//Author: Gisele de Melo
//This code was developed for learning purposes for the codedelphi.com blog, therefore I am not responsible for
//its use.
//------------------------------------------------------------------------------------------------------------

unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.JSON;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    Pedido: TJSONObject; //Variável Pedido que será acessada por todos os métodos que serão criados
    procedure CriarJSONAninhado;
    procedure AtualizarEndereco(Pedido: TJSONObject);
    procedure LerDadosDoPedido(Pedido: TJSONObject);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  CriarJSONAninhado;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  AtualizarEndereco(Pedido);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  LerDadosDoPedido(Pedido);
end;

procedure TForm1.CriarJSONAninhado;
var
  Cliente, Endereco: TJSONObject;
  Itens: TJSONArray;

begin
  if not Assigned(Pedido) then
    Exit;

  Cliente := TJSONObject.Create;
  Cliente.AddPair('Nome', 'João Silva');
  Cliente.AddPair('CPF', '123.456.789-00');

  Endereco := TJSONObject.Create;
  Endereco.AddPair('Rua', 'Av. Paulista');
  Endereco.AddPair('Número', '1000');
  Endereco.AddPair('Cidade', 'São Paulo');
  Endereco.AddPair('Estado', 'SP');
  Cliente.AddPair('Endereco', Endereco);

  Pedido.AddPair('Cliente', Cliente);

  Itens := TJSONArray.Create;
  Itens.AddElement(TJSONObject.Create.AddPair('Produto', 'Notebook').AddPair('Quantidade', '1').AddPair('Valor', '3500'));
  Itens.AddElement(TJSONObject.Create.AddPair('Produto', 'Mouse').AddPair('Quantidade', '2').AddPair('Valor', '150'));

  Pedido.AddPair('Itens', Itens);

  Memo1.Clear;
  // Saída do JSON
  Memo1.Lines.Add(Pedido.ToString);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Pedido := TJSONObject.Create;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  if Assigned(Pedido) then
    Pedido.Free;
end;

procedure TForm1.AtualizarEndereco(Pedido: TJSONObject);
var
  Cliente, NovoEndereco: TJSONObject;
begin
  Cliente := Pedido.GetValue<TJSONObject>('Cliente');
  if Assigned(Cliente) then
  begin
    NovoEndereco := TJSONObject.Create;
    try
      NovoEndereco.AddPair('Rua', 'Rua Nova');
      NovoEndereco.AddPair('Número', '500');
      NovoEndereco.AddPair('Cidade', 'Rio de Janeiro');
      NovoEndereco.AddPair('Estado', 'RJ');

      Cliente.RemovePair('Endereco'); // Remove o endereço antigo
      Cliente.AddPair('Endereco', NovoEndereco); // Adiciona o novo endereço
      Memo1.Clear;
      Memo1.Lines.Add(Cliente.ToString);
    except
      NovoEndereco.Free;
      raise;
    end;
  end;
end;

procedure TForm1.LerDadosDoPedido(Pedido: TJSONObject);
var
  Cliente: TJSONObject;
  NomeCliente: string;
  Endereco: TJSONObject;
  Cidade: string;

begin
  Cliente := Pedido.GetValue<TJSONObject>('Cliente');
  Memo1.Clear;
  if Assigned(Cliente) then
  begin
    NomeCliente := Cliente.GetValue<string>('Nome');
    Memo1.Lines.Add('Nome do Cliente: ' + NomeCliente);

    Endereco := Cliente.GetValue<TJSONObject>('Endereco');
    if Assigned(Endereco) then
    begin
      Cidade := Endereco.GetValue<string>('Cidade');
      Memo1.Lines.Add('Cidade: ' + Cidade);
    end;
  end;
end;

end.
