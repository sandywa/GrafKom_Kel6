unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Buttons, StdCtrls, Spin, EditBtn;

type

  { TForm1 }
  elemen=record
    x,y:integer;
  end;

  TForm1 = class(TForm)
    baru: TButton;
    btAtas: TSpeedButton;
    btBawah: TSpeedButton;
    btBelahKetupat: TSpeedButton;
    btGaris: TSpeedButton;
    btHexagon: TSpeedButton;
    btKanan: TSpeedButton;
    btKiri: TSpeedButton;
    btLingkaran: TSpeedButton;
    btMinus: TSpeedButton;
    btPenghapus: TSpeedButton;
    btPensil: TSpeedButton;
    btPersegi: TSpeedButton;
    btPlus: TSpeedButton;
    btSegi3: TSpeedButton;
    btSegilima: TSpeedButton;
    btSegitiga: TSpeedButton;
    btTrapesium: TSpeedButton;
    btWarna: TSpeedButton;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    GroupBox6: TGroupBox;
    KananAtas: TSpeedButton;
    KananBawah: TSpeedButton;
    kiriAtas: TSpeedButton;
    KiriBawah: TSpeedButton;
    Label1: TLabel;
    MirrorDown: TSpeedButton;
    MirrorRight: TSpeedButton;
    PutarKanan: TBitBtn;
    PutarKanan1: TBitBtn;
    ShearHor: TButton;
    ShearVer: TButton;
    ColorDialog1: TColorDialog;
    GroupBox1: TGroupBox;
    Panel1: TPanel;
    btopen: TBitBtn;
    btsave: TBitBtn;
    Image1: TImage;
    OpenDialog1: TOpenDialog;
    RadioGroup1: TRadioGroup;
    SaveDialog1: TSaveDialog;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    SpinEdit3: TSpinEdit;
    SpinEdit4: TSpinEdit;
    SpinEdit5: TSpinEdit;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    StaticText3: TStaticText;
    StaticText4: TStaticText;
    procedure baruClick(Sender: TObject);
    procedure btAtasClick(Sender: TObject);
    procedure btBawahClick(Sender: TObject);
    procedure btKananClick(Sender: TObject);
    procedure btKiriClick(Sender: TObject);
    procedure btLingkaranClick(Sender: TObject);
    procedure btMinusClick(Sender: TObject);
    procedure btnewClick(Sender: TObject);
    procedure btopenClick(Sender: TObject);
    procedure btPensilClick(Sender: TObject);
    procedure btPersegiClick(Sender: TObject);
    procedure btPlusClick(Sender: TObject);
    procedure btsaveClick(Sender: TObject);
    procedure btSegitigaClick(Sender: TObject);
    procedure btWarnaClick(Sender: TObject);
    procedure ShearHorClick(Sender: TObject);
    procedure ShearVerClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer
      );
    procedure Image1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure KananAtasClick(Sender: TObject);
    procedure KananBawahClick(Sender: TObject);
    procedure kiriAtasClick(Sender: TObject);
    procedure KiriBawahClick(Sender: TObject);
    procedure PutarKanan1Click(Sender: TObject);
    procedure PutarKananClick(Sender: TObject);
    procedure MirrorDownClick(Sender: TObject);
    procedure MirrorRightClick(Sender: TObject);
    procedure btCropClick(Sender: TObject);
    procedure btSegilimaClick(Sender: TObject);
    procedure btTrapesiumClick(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure btGarisClick(Sender: TObject);
    procedure btPenghapusClick(Sender: TObject);
    procedure btHexagonClick(Sender: TObject);
    procedure btSegi3Click(Sender: TObject);
    procedure btBelahKetupatClick(Sender: TObject);
    procedure TitikTengah(Sender:TObject);
    procedure FloodFill(x,y,fill,current:integer);
  private

  public

  end;

var
  Form1: TForm1;
  x,y,i,m,n:integer;
  o:array[1..50] of elemen;
  tob:elemen;
  tmp:array[1..50] of elemen;
  objek,titik: Integer;
  cat,pensil,garis,tergambar,penghapus,nggambar,hapus:boolean;
  x0,y0,x1,y1:Integer;
  penState : Boolean;
  cropState : Boolean;
  selectState : Boolean;
  mouseState : Boolean;
  mouseAwal : TPoint;
  mouseAkhir : TPoint;
  bitmap_back : TBitmap;
  bitmap_crop : TBitmap;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.btnewClick(Sender: TObject);
begin
  //Image1.Canvas.Rectangle(0,0,Image1.Width,Image1.Height);
  Image1.Canvas.Rectangle(0,0,Image1.Width,Image1.Height);
  cat:=false;
  garis:=false;
  pensil:=false;

end;
procedure TForm1.FloodFill(x,y,fill,current:integer);
begin
  if Image1.Canvas.Pixels[x,y]=current then
  begin
    Image1.Canvas.Pixels[x,y]:=fill;
    Image1.Canvas.Refresh;
    floodFill(x+1,y,fill,current);
    floodFill(x-1,y,fill,current);
    floodFill(x,y+1,fill,current);
    floodFill(x,y-1,fill,current);
  end;
end;

procedure TForm1.btMinusClick(Sender: TObject);
begin
  for i:=1 to titik do
  begin
    o[i].x:=o[i].x-tob.x;
    o[i].y:=o[i].y-tob.y;
    tmp[i].x:=round(o[i].x div SpinEdit1.Value);
    tmp[i].y:=round(o[i].y div SpinEdit1.Value);
    o[i]:=tmp[i];
    o[i].x:=o[i].x+tob.x;
    o[i].y:=o[i].y+tob.y;
  end;
  FormShow(Sender);
  if cat=true then FloodFill(tob.x,tob.y,ColorDialog1.Color,Image1.Canvas.Pixels[tob.x,tob.y]);
end;

procedure TForm1.btLingkaranClick(Sender: TObject);
begin
  //lingkaran
  penghapus:=false;
  pensil:=False;
  cat:=False;
  objek:=3; titik:=2;
  o[1].x:=50;     o[1].y:=50;
  o[2].x:=180;     o[2].y:=180;
  TitikTengah(Sender);
  FormShow(Sender);
end;

procedure TForm1.btAtasClick(Sender: TObject);
begin
  for i:=1 to titik do
  begin
   o[i].y:=o[i].y-SpinEdit2.Value;
  end;
  TitikTengah(Sender);
  FormShow(Sender);
  if cat=true then FloodFill(tob.x,tob.y,ColorDialog1.Color,Image1.Canvas.Pixels[tob.x,tob.y]);
end;

procedure TForm1.baruClick(Sender: TObject);
begin
  Image1.Canvas.Clear;
  Image1.Canvas.Pen.Width:=1;
  Image1.Canvas.FillRect(0,0,Image1.Width,Image1.Height);
  pensil:=false;
  cat:=false;
  garis:=false;
  penghapus:=false;
end;

procedure TForm1.btBawahClick(Sender: TObject);
begin
  for i:=1 to titik do
  begin
   o[i].y:=o[i].y+SpinEdit2.Value;
  end;
  TitikTengah(Sender);
  FormShow(Sender);
  if cat=true then FloodFill(tob.x,tob.y,ColorDialog1.Color,Image1.Canvas.Pixels[tob.x,tob.y]);
end;

procedure TForm1.btKananClick(Sender: TObject);
begin
  for i:=1 to titik do
  begin
   o[i].x:=o[i].x+SpinEdit2.Value;
  end;
  TitikTengah(Sender);
  FormShow(Sender);
  if cat=true then FloodFill(tob.x,tob.y,ColorDialog1.Color,Image1.Canvas.Pixels[tob.x,tob.y]);
end;

procedure TForm1.btKiriClick(Sender: TObject);
begin
  for i:=1 to titik do
  begin
   o[i].x:=o[i].x-SpinEdit2.Value;
  end;
  TitikTengah(Sender);
  FormShow(Sender);
  if cat=true then FloodFill(tob.x,tob.y,ColorDialog1.Color,Image1.Canvas.Pixels[tob.x,tob.y]);
end;

procedure TForm1.TitikTengah(Sender: TObject);
begin
  //tob(titik tengah objek:elemen=record)
  //tob = rata"
  tob.x:=0;
  tob.y:=0;
  for i:=1 to titik do
  begin
    tob.x:=tob.x+o[i].x;
    tob.y:=tob.y+o[i].y;
  end;
  tob.x:=tob.x div titik;
  tob.y:=tob.y div titik;
end;

procedure TForm1.btopenClick(Sender: TObject);
begin
  cat:=false;
  garis:=false;
  pensil:=false;
  penghapus:=false;
  OpenDialog1.Execute;
end;

procedure TForm1.btPensilClick(Sender: TObject);
begin
  cat:=false;
  garis:=false;
  pensil:=true;
  penghapus:=false;
  selectState := False;
  penState:= true;
end;

procedure TForm1.btPersegiClick(Sender: TObject);
begin
  //persegi
  penghapus:=false;
  pensil:=False;
  cat:=False;
  titik:=5; objek:=1;
  o[1].x:=50;   o[1].y:=50;
  o[2].x:=150;   o[2].y:=50;
  o[3].x:=150;   o[3].y:=150;
  o[4].x:=50;   o[4].y:=150;
  o[5].x:=50;   o[5].y:=50;
  TitikTengah(Sender);
  FormShow(Sender);
end;

procedure TForm1.btPlusClick(Sender: TObject);
begin
  for i:=1 to titik do
  begin
    o[i].x:=o[i].x-tob.x;
    o[i].y:=o[i].y-tob.y;
    tmp[i].x:=round(o[i].x*SpinEdit1.Value);
    tmp[i].y:=round(o[i].y*SpinEdit1.Value);
    o[i]:=tmp[i];
    o[i].x:=o[i].x+tob.x;
    o[i].y:=o[i].y+tob.y;
  end;
  FormShow(Sender);
  if cat=true then FloodFill(tob.x,tob.y,ColorDialog1.Color,Image1.Canvas.Pixels[tob.x,tob.y]);
end;

procedure TForm1.btsaveClick(Sender: TObject);
begin
  if SaveDialog1.Execute then Image1.Picture.SaveToFile(SaveDialog1.FileName);
end;

procedure TForm1.btSegitigaClick(Sender: TObject);
begin
  //segitiga
  penghapus:=false;
  pensil:=False;
  cat:=False;
  titik:=4; objek:=2;
  o[1].x:=50;   o[1].y:=150;
  o[2].x:=150;   o[2].y:=150;
  o[3].x:=100;   o[3].y:=50;
  o[4].x:=50;   o[4].y:=150;
  TitikTengah(Sender);
  FormShow(Sender);
end;

procedure TForm1.btWarnaClick(Sender: TObject);
begin
  cat:=true;
  garis:=false;
  pensil:=false;
  penghapus:=false;
  ColorDialog1.Execute;
end;

procedure TForm1.ShearHorClick(Sender: TObject);
begin

if objek=1 then
begin
   o[1].x:=o[1].x+SpinEdit5.Value;
   o[2].x:=o[2].x+SpinEdit5.Value;
   o[3].x:=o[3].x-SpinEdit5.Value;
   o[4].x:=o[4].x-SpinEdit5.Value;
   o[5].x:=o[5].x+SpinEdit5.Value;
   TitikTengah(Sender);
   FormShow(Sender);
   if cat=true then FloodFill(tob.x,tob.y,ColorDialog1.Color,Image1.Canvas.Pixels[tob.x,tob.y]);
end;

if objek=2 then
begin
   o[1].x:=o[1].x-SpinEdit5.Value;
   o[2].x:=o[2].x-SpinEdit5.Value;
   o[3].x:=o[3].x+SpinEdit5.Value;
   o[4].x:=o[4].x-SpinEdit5.Value;
   TitikTengah(Sender);
   FormShow(Sender);
   if cat=true then FloodFill(tob.x,tob.y,ColorDialog1.Color,Image1.Canvas.Pixels[tob.x,tob.y]);
end;
if objek=3 then
begin
  o[1].x:=o[1].x+SpinEdit5.Value;
  o[2].x:=o[2].x-SpinEdit5.Value;
  TitikTengah(Sender);
  FormShow(Sender);
  if cat=true then FloodFill(tob.x,tob.y,ColorDialog1.Color,Image1.Canvas.Pixels[tob.x,tob.y]);
end;
if objek=4 then
begin
  o[1].x:=o[1].x+SpinEdit5.Value;
  o[2].x:=o[2].x+SpinEdit5.Value;
  o[3].x:=o[3].x-SpinEdit5.Value;
  o[4].x:=o[4].x-SpinEdit5.Value;
  o[5].x:=o[5].x+SpinEdit5.Value;
  o[6].x:=o[6].x+SpinEdit5.Value;
  TitikTengah(Sender);
  FormShow(Sender);
  if cat=true then FloodFill(tob.x,tob.y,ColorDialog1.Color,Image1.Canvas.Pixels[tob.x,tob.y]);
end;
if objek=5 then
begin
   o[1].x:=o[1].x+SpinEdit5.Value;
   o[2].x:=o[2].x+SpinEdit5.Value;
   o[3].x:=o[3].x-SpinEdit5.Value;
   o[4].x:=o[4].x-SpinEdit5.Value;
   o[5].x:=o[5].x+SpinEdit5.Value;
   TitikTengah(Sender);
   FormShow(Sender);
   if cat=true then FloodFill(tob.x,tob.y,ColorDialog1.Color,Image1.Canvas.Pixels[tob.x,tob.y]);
end;
if objek=6 then
begin
   o[1].x:=o[1].x+SpinEdit5.Value;
   o[2].x:=o[2].x+SpinEdit5.Value;
   o[3].x:=o[3].x-SpinEdit5.Value;
   o[4].x:=o[4].x-SpinEdit5.Value;
   o[5].x:=o[5].x-SpinEdit5.Value;
   o[6].x:=o[6].x+SpinEdit5.Value;
   o[7].x:=o[7].x+SpinEdit5.Value;
   TitikTengah(Sender);
   FormShow(Sender);
   if cat=true then FloodFill(tob.x,tob.y,ColorDialog1.Color,Image1.Canvas.Pixels[tob.x,tob.y]);
end;
if objek=7 then
begin
  o[1].x:=o[1].x+SpinEdit5.Value;
  o[2].x:=o[2].x+SpinEdit5.Value;
  o[3].x:=o[3].x+SpinEdit5.Value;
  o[4].x:=o[4].x-SpinEdit5.Value;
  o[5].x:=o[5].x-SpinEdit5.Value;
  o[6].x:=o[6].x-SpinEdit5.Value;
  o[7].x:=o[7].x-SpinEdit5.Value;;
  o[8].x:=o[8].x+SpinEdit5.Value;
  o[9].x:=o[9].x+SpinEdit5.Value;
  o[10].x:=o[10].x+SpinEdit5.Value;
  TitikTengah(Sender);
  FormShow(Sender);
  if cat=true then FloodFill(tob.x,tob.y,ColorDialog1.Color,Image1.Canvas.Pixels[tob.x,tob.y]);
end;
if objek=8 then
begin
   o[1].x:=o[1].x+SpinEdit5.Value;
   o[2].x:=o[2].x-SpinEdit5.Value;
   o[3].x:=o[3].x-SpinEdit5.Value;
   o[4].x:=o[4].x+SpinEdit5.Value;
   TitikTengah(Sender);
   FormShow(Sender);
   if cat=true then FloodFill(tob.x,tob.y,ColorDialog1.Color,Image1.Canvas.Pixels[tob.x,tob.y]);
end;
//assdwas

end;

procedure TForm1.ShearVerClick(Sender: TObject);
begin
if objek=1 then
begin
   o[1].y:=o[1].y+SpinEdit5.Value;
   o[2].y:=o[2].y-SpinEdit5.Value;
   o[3].y:=o[3].y-SpinEdit5.Value;
   o[4].y:=o[4].y+SpinEdit5.Value;
   o[5].y:=o[5].y+SpinEdit5.Value;
   TitikTengah(Sender);
   FormShow(Sender);
   if cat=true then FloodFill(tob.x,tob.y,ColorDialog1.Color,Image1.Canvas.Pixels[tob.x,tob.y]);
end;
if objek=2 then
begin
  o[1].y:=o[1].y+SpinEdit5.Value;
  o[2].y:=o[2].y-SpinEdit5.Value;
  o[3].y:=o[3].y+SpinEdit5.Value;
  o[4].y:=o[4].y+SpinEdit5.Value;
  TitikTengah(Sender);
  FormShow(Sender);
  if cat=true then FloodFill(tob.x,tob.y,ColorDialog1.Color,Image1.Canvas.Pixels[tob.x,tob.y]);
end;
if objek=3 then
begin
  o[1].y:=o[1].y+SpinEdit5.Value;
  o[2].y:=o[2].y-SpinEdit5.Value;
  TitikTengah(Sender);
  FormShow(Sender);
  if cat=true then FloodFill(tob.x,tob.y,ColorDialog1.Color,Image1.Canvas.Pixels[tob.x,tob.y]);
  end;
if objek=4 then
begin
   o[1].y:=o[1].y+SpinEdit5.Value;
   o[2].y:=o[2].y+SpinEdit5.Value;
   o[3].y:=o[3].y+SpinEdit5.Value;
   o[4].y:=o[4].y-SpinEdit5.Value;
   o[5].y:=o[5].y-SpinEdit5.Value;
   o[6].y:=o[6].y+SpinEdit5.Value;
   TitikTengah(Sender);
   FormShow(Sender);
   if cat=true then FloodFill(tob.x,tob.y,ColorDialog1.Color,Image1.Canvas.Pixels[tob.x,tob.y]);
  end;
if objek=5 then
begin
   o[1].y:=o[1].y+SpinEdit5.Value;
   o[2].y:=o[2].y-SpinEdit5.Value;
   o[3].y:=o[3].y-SpinEdit5.Value;
   o[4].y:=o[4].y+SpinEdit5.Value;
   o[5].y:=o[5].y+SpinEdit5.Value;
   TitikTengah(Sender);
   FormShow(Sender);
   if cat=true then FloodFill(tob.x,tob.y,ColorDialog1.Color,Image1.Canvas.Pixels[tob.x,tob.y]);
   end;
if objek=6 then
begin
   o[1].y:=o[1].y-SpinEdit5.Value;
   o[2].y:=o[2].y-SpinEdit5.Value;
   o[3].y:=o[3].y-SpinEdit5.Value;
   o[4].y:=o[4].y+SpinEdit5.Value;
   o[5].y:=o[5].y+SpinEdit5.Value;
   o[6].y:=o[6].y+SpinEdit5.Value;
   o[7].y:=o[7].y-SpinEdit5.Value;
   TitikTengah(Sender);
   FormShow(Sender);
   if cat=true then FloodFill(tob.x,tob.y,ColorDialog1.Color,Image1.Canvas.Pixels[tob.x,tob.y]);
   end;
if objek=7 then
begin
   o[1].y:=o[1].y-SpinEdit5.Value;
   o[2].y:=o[2].y-SpinEdit5.Value;
   o[3].y:=o[3].y-SpinEdit5.Value;
   o[4].y:=o[4].y-SpinEdit5.Value;
   o[5].y:=o[5].y-SpinEdit5.Value;
   o[6].y:=o[6].y+SpinEdit5.Value;
   o[7].y:=o[7].y+SpinEdit5.Value;
   o[8].y:=o[8].y+SpinEdit5.Value;
   o[9].y:=o[9].y+SpinEdit5.Value;
   o[10].y:=o[10].y+SpinEdit5.Value;
   TitikTengah(Sender);
   FormShow(Sender);
   if cat=true then FloodFill(tob.x,tob.y,ColorDialog1.Color,Image1.Canvas.Pixels[tob.x,tob.y]);
   end;
if objek=8 then
begin
   o[1].y:=o[1].y-SpinEdit5.Value;
   o[2].y:=o[2].y-SpinEdit5.Value;
   o[3].y:=o[3].y+SpinEdit5.Value;
   o[4].y:=o[4].y+SpinEdit5.Value;
   TitikTengah(Sender);
   FormShow(Sender);
   if cat=true then FloodFill(tob.x,tob.y,ColorDialog1.Color,Image1.Canvas.Pixels[tob.x,tob.y]);
   end;
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
  Image1.Canvas.FillRect(0,0,Image1.Width,Image1.Height);
  Image1.Canvas.Pen.Width:=SpinEdit4.Value;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin

end;

procedure TForm1.FormShow(Sender: TObject);
begin
  Image1.Canvas.Rectangle(0,0,Image1.Width,Image1.Height);
  Image1.Canvas.Pen.Width:=SpinEdit4.Value;
  //persegi
  if objek=1 then
  begin
    Image1.Canvas.MoveTo(o[1].x,o[1].y);
    for i:=2 to 5 do
        Image1.Canvas.LineTo(o[i].x,o[i].y);
  end;
  //segitiga
  if objek=2 then
  begin
    Image1.Canvas.MoveTo(o[1].x,o[1].y);
    for i:=2 to titik do
        Image1.Canvas.LineTo(o[i].x,o[i].y);
  end;
  //lingkaran
  if objek=3 then
  begin
    Image1.Canvas.Ellipse(o[1].x,o[1].y,o[2].x,o[2].y);
  end;
  //segilima
  if objek=4 then
  begin
    Image1.Canvas.MoveTo(o[1].x,o[1].y);
    for i:=2 to titik do
        Image1.Canvas.LineTo(o[i].x,o[i].y);
  end;
  //trapesium
  if objek=5 then
  begin
    Image1.Canvas.MoveTo(o[1].x,o[1].y);
    for i:=2 to titik do
        Image1.Canvas.LineTo(o[i].x,o[i].y);
  end;
  //hexagon
  if objek=6 then
  begin
    Image1.Canvas.MoveTo(o[1].x,o[1].y);
    for i:=1 to titik do
                      Image1.Canvas.LineTo(o[i].x,o[i].y);
  end;
  //bintang
  if objek=7 then
  begin
    Image1.Canvas.MoveTo(o[1].x,o[1].y);
    for i:=titik downto 1 do
    Image1.Canvas.LineTo(o[i].x,o[i].y);
  end;
  //ketupat
   if objek=8 then
  begin
    Image1.Canvas.MoveTo(o[1].x,o[1].y);
    for i:=titik downto 1 do
    Image1.Canvas.LineTo(o[i].x,o[i].y);
  end;

end;

procedure TForm1.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image1.Canvas.Pen.Width:=SpinEdit4.Value;
  if RadioGroup1.ItemIndex=0 then Image1.Canvas.Pen.Style:=psDash;
  if RadioGroup1.ItemIndex=1 then Image1.Canvas.Pen.Style:=psDot;
  if RadioGroup1.ItemIndex=2 then Image1.Canvas.Pen.Style:=psSolid;
  if cat=true then FloodFill(X,Y,ColorDialog1.Color,Image1.Canvas.Pixels[X,Y]);
  if pensil=true then
  begin
    nggambar:=true;
    Image1.Canvas.Pen.Color:=clBlack;
    Image1.Canvas.MoveTo(X,Y);
  end;
  if penghapus=true then
  begin
    hapus:=true;
    Image1.Canvas.Pen.Color:=clWhite;
    Image1.Canvas.MoveTo(X,Y);
  end;
  if garis=true then
  begin
    tergambar:=true;
    x0:=X;
    y0:=Y;
  end;
  mouseState:=True;
  mouseAwal := TPoint.Create(X,Y);
    if cropState then
  begin
     //bitmap_back:= TBitmap.Create;
     //bitmap_back.Canvas.Clear;
     //bitmap_back.SetSize(Image1.Canvas.Width,Image1.Canvas.Height);
     // (area tujuan,dari kanvas,area yang dicopy)
     //bitmap_back.Canvas.CopyRect(TRect.Create(0,0,bitmap_back.Width,bitmap_back.Height),Image1.Canvas,TRect.Create(0,0,bitmap_back.Width,bitmap_back.Height));
  end;
  if selectState then
  begin
     bitmap_back:= TBitmap.Create;
     bitmap_back.Canvas.Clear;
     bitmap_back.SetSize(Image1.Canvas.Width,Image1.Canvas.Height);
     // (area tujuan,dari kanvas,area yang dicopy)
     bitmap_back.Canvas.CopyRect(TRect.Create(0,0,bitmap_back.Width,bitmap_back.Height),Image1.Canvas,TRect.Create(0,0,bitmap_back.Width,bitmap_back.Height));

     Image1.Canvas.Pen.Color:=clRed;
     Image1.Canvas.Pen.Style:=psDash;
     Image1.Canvas.MoveTo(X,Y);
  end;

end;

procedure TForm1.Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  StaticText3.Caption:=inttostr(X);
  StaticText4.Caption:=inttostr(Y);
  //Image1.Canvas.MoveTo(x0,y0);
  if nggambar=true then
  begin
    Image1.Canvas.LineTo(X,Y);
  end;
  if hapus then Image1.Canvas.LineTo(X,Y);;
  if selectState and mouseState then
  begin
     Image1.Canvas.CopyRect(TRect.Create(0,0,Image1.Canvas.Width,Image1.Canvas.Height),bitmap_back.Canvas,TRect.Create(0,0,Image1.Canvas.Width,Image1.Canvas.Height));
     Image1.Canvas.Brush.Style:=bsClear;
     Image1.Canvas.Rectangle(mouseAwal.x,mouseAwal.Y,X,Y);
  end;
  if cropState and mouseState then
  begin
     Image1.Canvas.CopyRect(TRect.Create(0,0,Image1.Canvas.Width,Image1.Canvas.Height),bitmap_back.Canvas,TRect.Create(0,0,Image1.Canvas.Width,Image1.Canvas.Height));
     mouseAwal := TPoint.Create(X,Y);
     mouseAkhir := mouseAwal.Add(TPoint.Create(bitmap_crop.Canvas.Width,bitmap_crop.Canvas.Height));
     Image1.Canvas.CopyRect(TRect.Create(mouseAwal,mouseAkhir),bitmap_crop.Canvas,TRect.Create(0,0,bitmap_crop.Canvas.Width,bitmap_crop.Canvas.Height));
     Image1.Canvas.Brush.Style:=bsClear;
     Image1.Canvas.Rectangle(mouseAwal.x,mouseAwal.Y,X,Y);
  end;

end;

procedure TForm1.Image1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  nggambar:=false;
  hapus:=false;
  Image1.Canvas.Pen.Color:=clBlack;
  if garis=true then
  begin
    //Image1.Canvas.Rectangle(0,0,Image1.Width,Image1.Height);
    tergambar:=false;
    x1:=X;
    y1:=Y;
    Image1.Canvas.MoveTo(x0,y0);
    Image1.Canvas.LineTo(x1,y1);
  end;
  mouseAkhir := TPoint.Create(X,Y);
  mouseState:=False;
  if cropState then begin
      cropState := False;

  end;
  if selectState then
  begin
     Image1.Canvas.CopyRect(TRect.Create(0,0,Image1.Canvas.Width,Image1.Canvas.Height),bitmap_back.Canvas,TRect.Create(0,0,Image1.Canvas.Width,Image1.Canvas.Height));


     // ambil dulu
     bitmap_crop := TBitmap.Create;
     bitmap_crop.Canvas.Clear;
     bitmap_crop.SetSize(abs(mouseAwal.Subtract(mouseAkhir).x),abs(mouseAwal.Subtract(mouseAkhir).y));
     bitmap_crop.Canvas.CopyRect(TRect.Create(0,0,abs(mouseAwal.Subtract(mouseAkhir).x),abs(mouseAwal.Subtract(mouseAkhir).y)),bitmap_back.Canvas,TRect.Create(mouseAwal,mouseAkhir));

     // bersihkan area
     Image1.Canvas.Pen.Style:=psClear;
     Image1.Canvas.Pen.Color:=clWhite;
     Image1.Canvas.Brush.Style:=bsSolid;
     Image1.Canvas.Brush.Color:=clWhite;
     Image1.Canvas.Rectangle(TRect.Create(mouseAwal,mouseAkhir));

     // kembalikan
     bitmap_back.Canvas.CopyRect(TRect.Create(0,0,bitmap_back.Width,bitmap_back.Height),Image1.Canvas,TRect.Create(0,0,bitmap_back.Width,bitmap_back.Height));
     //Image1.Canvas.CopyRect(TRect.Create(mouseAwal,mouseAkhir),bitmap_back.Canvas,TRect.Create(mouseAwal,mouseAkhir));
     Image1.Canvas.CopyRect(TRect.Create(mouseAwal,mouseAkhir),bitmap_crop.Canvas,TRect.Create(0,0,bitmap_crop.Canvas.Width,bitmap_crop.Canvas.Height));
     Image1.Canvas.Pen.Style:=psDash;
     Image1.Canvas.Pen.Color:=clRed;
     Image1.Canvas.Brush.Style:=bsClear;
     Image1.Canvas.Rectangle(mouseAwal.x,mouseAwal.Y,X,Y);
     selectState := false;
     cropState := true;
  end;

end;

procedure TForm1.KananAtasClick(Sender: TObject);
begin
  for i:=1 to titik do
  begin
   o[i].y:=o[i].y-SpinEdit2.Value;
   o[i].x:=o[i].x+SpinEdit2.Value;
  end;
  TitikTengah(Sender);
  FormShow(Sender);
  if cat=true then FloodFill(tob.x,tob.y,ColorDialog1.Color,Image1.Canvas.Pixels[tob.x,tob.y]);
end;

procedure TForm1.KananBawahClick(Sender: TObject);
begin
  for i:=1 to titik do
  begin
   o[i].y:=o[i].y+SpinEdit2.Value;
   o[i].x:=o[i].x+SpinEdit2.Value;
  end;
  TitikTengah(Sender);
  FormShow(Sender);
  if cat=true then FloodFill(tob.x,tob.y,ColorDialog1.Color,Image1.Canvas.Pixels[tob.x,tob.y]);
end;

procedure TForm1.kiriAtasClick(Sender: TObject);
begin
  for i:=1 to titik do
  begin
   o[i].y:=o[i].y-SpinEdit2.Value;
   o[i].x:=o[i].x-SpinEdit2.Value;
  end;
  TitikTengah(Sender);
  FormShow(Sender);
  if cat=true then FloodFill(tob.x,tob.y,ColorDialog1.Color,Image1.Canvas.Pixels[tob.x,tob.y]);
end;

procedure TForm1.KiriBawahClick(Sender: TObject);
begin
  for i:=1 to titik do
  begin
   o[i].y:=o[i].y+SpinEdit2.Value;
   o[i].x:=o[i].x-SpinEdit2.Value;
  end;
  TitikTengah(Sender);
  FormShow(Sender);
  if cat=true then FloodFill(tob.x,tob.y,ColorDialog1.Color,Image1.Canvas.Pixels[tob.x,tob.y]);
end;

procedure TForm1.PutarKanan1Click(Sender: TObject);
var
  sdt:real;
begin
  sdt:=-SpinEdit3.Value*pi/180;
  for i:=1 to titik do
  begin
    o[i].x:=o[i].x-tob.x;
    o[i].y:=o[i].y-tob.y;
    tmp[i].x:=round(o[i].x*cos(sdt)-o[i].y*sin(sdt));
    tmp[i].y:=round(o[i].x*sin(sdt)+o[i].y*cos(sdt));
    o[i]:=tmp[i];
    o[i].x:=o[i].x+tob.x;
    o[i].y:=o[i].y+tob.y;
  end;
  FormShow(Sender);
  if cat=true then FloodFill(tob.x,tob.y,ColorDialog1.Color,Image1.Canvas.Pixels[tob.x,tob.y]);
end;

procedure TForm1.PutarKananClick(Sender: TObject);
var
  sdt:Real;
begin
  sdt:=SpinEdit3.Value*pi/180;
  for i:=1 to titik do
  begin
    o[i].x:=o[i].x-tob.x;
    o[i].y:=o[i].y-tob.y;
    tmp[i].x:=round(o[i].x*cos(sdt)-o[i].y*sin(sdt));
    tmp[i].y:=round(o[i].x*sin(sdt)+o[i].y*cos(sdt));
    o[i]:=tmp[i];
    o[i].x:=o[i].x+tob.x;
    o[i].y:=o[i].y+tob.y;
  end;
  FormShow(Sender);
  if cat=true then FloodFill(tob.x,tob.y,ColorDialog1.Color,Image1.Canvas.Pixels[tob.x,tob.y]);
end;

procedure TForm1.MirrorDownClick(Sender: TObject);
begin
  //segiempat
  if objek=1 then
  begin
      m:=Image1.Width;
      n:=Image1.Height div 2;
      Image1.Canvas.MoveTo(0,n);
      Image1.Canvas.LineTo(m,n);
      for i:=1 to 5 do
      begin
           tmp[i].y:=(o[i].y-(2*(o[i].y-n)));
           tmp[i].x:=o[i].x;
      end;
          Image1.Canvas.MoveTo(tmp[5].x,tmp[5].y);
      for i:=1 to 5 do
      begin
           Image1.Canvas.LineTo(tmp[i].x,tmp[i].y);
      end;
  end;
  //segitiga
  if objek=2 then
  begin
     m:=Image1.Width ;
     n:=Image1.Height div 2;
     Image1.Canvas.MoveTo(0,n);
     Image1.Canvas.LineTo(m,n);
     for i:=1 to 4 do
     begin
     tmp[i].y:=(o[i].y-(2*(o[i].y-n)));
     tmp[i].x:=o[i].x;
     end;
     Image1.Canvas.MoveTo(tmp[4].x,tmp[4].y);
     for i:=1 to 4 do
     begin
     Image1.Canvas.LineTo(tmp[i].x,tmp[i].y);
     end;
  end;
  //lingkaran
  if objek=3 then
  begin
     m:=Image1.Width ;
     n:=Image1.Height div 2;
     Image1.Canvas.MoveTo(0,n);
     Image1.Canvas.LineTo(m,n);
     for i:=1 to 2 do
     begin
     tmp[i].y:=(o[i].y-(2*(o[i].y-n)));
     tmp[i].x:=o[i].x;
     end;
     //Image1.Canvas.MoveTo(tmp[2].x,tmp[2].y);
     Image1.Canvas.Ellipse(tmp[1].x,tmp[1].y,tmp[2].x,tmp[2].y);
     //for i:=1 to 2 do
     //begin
     //Image1.Canvas.LineTo(tmp[i].x,tmp[i].y);
     //end;
  end;
  //segilima
   if objek=4 then
  begin
     m:=Image1.Width ;
     n:=Image1.Height div 2;
     Image1.Canvas.MoveTo(0,n);
     Image1.Canvas.LineTo(m,n);
     for i:=1 to 6 do
     begin
     tmp[i].y:=(o[i].y-(2*(o[i].y-n)));
     tmp[i].x:=o[i].x;
     end;
     Image1.Canvas.MoveTo(tmp[6].x,tmp[6].y);
     for i:=1 to 6 do
     begin
     Image1.Canvas.LineTo(tmp[i].x,tmp[i].y);
     end;
  end;
   //trapesium
    if objek=5 then
  begin
     m:=Image1.Width ;
     n:=Image1.Height div 2;
     Image1.Canvas.MoveTo(0,n);
     Image1.Canvas.LineTo(m,n);
     for i:=1 to 5 do
     begin
     tmp[i].y:=(o[i].y-(2*(o[i].y-n)));
     tmp[i].x:=o[i].x;
     end;
     Image1.Canvas.MoveTo(tmp[5].x,tmp[5].y);
     for i:=1 to 5 do
     begin
     Image1.Canvas.LineTo(tmp[i].x,tmp[i].y);
     end;
  end;
    //hexagon
     if objek=6 then
  begin
     m:=Image1.Width ;
     n:=Image1.Height div 2;
     Image1.Canvas.MoveTo(0,n);
     Image1.Canvas.LineTo(m,n);
     for i:=1 to 7 do
     begin
     tmp[i].y:=(o[i].y-(2*(o[i].y-n)));
     tmp[i].x:=o[i].x;
     end;
     Image1.Canvas.MoveTo(tmp[7].x,tmp[7].y);
     for i:=1 to 7 do
     begin
     Image1.Canvas.LineTo(tmp[i].x,tmp[i].y);
     end;
  end;
     //bintang
      if objek=7 then
  begin
     m:=Image1.Width ;
     n:=Image1.Height div 2;
     Image1.Canvas.MoveTo(0,n);
     Image1.Canvas.LineTo(m,n);
     for i:=1 to 10 do
     begin
     tmp[i].y:=(o[i].y-(2*(o[i].y-n)));
     tmp[i].x:=o[i].x;
     end;
     Image1.Canvas.MoveTo(tmp[10].x,tmp[10].y);
     for i:=1 to 10 do
     begin
     Image1.Canvas.LineTo(tmp[i].x,tmp[i].y);
     end;
  end;
      //belahketupat
      if objek=8 then
  begin
     m:=Image1.Width ;
     n:=Image1.Height div 2;
     Image1.Canvas.MoveTo(0,n);
     Image1.Canvas.LineTo(m,n);
     for i:=1 to 4 do
     begin
     tmp[i].y:=(o[i].y-(2*(o[i].y-n)));
     tmp[i].x:=o[i].x;
     end;
     Image1.Canvas.MoveTo(tmp[4].x,tmp[4].y);
     for i:=1 to 4 do
     begin
     Image1.Canvas.LineTo(tmp[i].x,tmp[i].y);
     end;
  end;
  //TitikTengah(Sender);
  //if cat=true then FloodFill(tob.x,tob.y,ColorDialog1.Color,Image1.Canvas.Pixels[tob.x,tob.y]);
end;

procedure TForm1.MirrorRightClick(Sender: TObject);
begin
  //segiempat
  if objek=1 then
  begin
      m:=Image1.Width div 2;
      n:=Image1.Height ;
    Image1.Canvas.MoveTo(m,0);
     Image1.Canvas.LineTo(m,n);
       for i:=1 to 5 do
      begin
           tmp[i].x:=(o[i].x-(2*(o[i].x-m)));
           tmp[i].y:=o[i].y;
      end;
      Image1.Canvas.MoveTo(tmp[5].x,tmp[5].y);
      for i:=1 to 5 do
      begin
      Image1.Canvas.LineTo(tmp[i].x,tmp[i].y);
      end;
  end;
  //segitiga
  if objek=2 then
  begin
     m:=Image1.Width div 2;
     n:=Image1.Height ;
     Image1.Canvas.MoveTo(m,0);
     Image1.Canvas.LineTo(m,n);
     for i:=1 to 4 do
     begin
     tmp[i].x:=(o[i].x-(2*(o[i].x-m)));
     tmp[i].y:=o[i].y;
     end;
     Image1.Canvas.MoveTo(tmp[4].x,tmp[4].y);
     for i:=1 to 4 do
     begin
     Image1.Canvas.LineTo(tmp[i].x,tmp[i].y);
     end;
  end;
  //lingkaran
  if objek=3 then
  begin
     m:=Image1.Width div 2;
     n:=Image1.Height ;
     Image1.Canvas.MoveTo(m,0);
     Image1.Canvas.LineTo(m,n);
     for i:=1 to 4 do
     begin
     tmp[i].x:=(o[i].x-(2*(o[i].x-m)));
     tmp[i].y:=o[i].y;
     end;
     Image1.Canvas.Ellipse(tmp[1].x,tmp[1].y,tmp[2].x,tmp[2].y);
  end;
  //segilima
   if objek=4 then
  begin
     m:=Image1.Width div 2;
     n:=Image1.Height ;
     Image1.Canvas.MoveTo(m,0);
     Image1.Canvas.LineTo(m,n);
     for i:=1 to 6 do
     begin
     tmp[i].x:=(o[i].x-(2*(o[i].x-m)));
     tmp[i].y:=o[i].y;
     end;
     Image1.Canvas.MoveTo(tmp[6].x,tmp[6].y);
     for i:=1 to 6 do
     begin
     Image1.Canvas.LineTo(tmp[i].x,tmp[i].y);
     end;
  end;
   //trapesium
    if objek=5 then
  begin
     m:=Image1.Width div 2;
     n:=Image1.Height;
     Image1.Canvas.MoveTo(m,0);
     Image1.Canvas.LineTo(m,n);
     for i:=1 to 5 do
     begin
     tmp[i].x:=(o[i].x-(2*(o[i].x-m)));
     tmp[i].y:=o[i].y;
     end;
     Image1.Canvas.MoveTo(tmp[5].x,tmp[5].y);
     for i:=1 to 5 do
     begin
     Image1.Canvas.LineTo(tmp[i].x,tmp[i].y);
     end;
  end;
    //hexagon
     if objek=6 then
  begin
     m:=Image1.Width div 2;
     n:=Image1.Height ;
     Image1.Canvas.MoveTo(m,0);
     Image1.Canvas.LineTo(m,n);
     for i:=1 to 7 do
     begin
     tmp[i].x:=(o[i].x-(2*(o[i].x-m)));
     tmp[i].y:=o[i].y;
     end;
     Image1.Canvas.MoveTo(tmp[7].x,tmp[7].y);
     for i:=1 to 7 do
     begin
     Image1.Canvas.LineTo(tmp[i].x,tmp[i].y);
     end;
  end;
     //bintang
      if objek=7 then
  begin
     m:=Image1.Width div 2;
     n:=Image1.Height ;
     Image1.Canvas.MoveTo(m,0);
     Image1.Canvas.LineTo(m,n);
     for i:=1 to 10 do
     begin
     tmp[i].x:=(o[i].x-(2*(o[i].x-m)));
     tmp[i].y:=o[i].y;
     end;
     Image1.Canvas.MoveTo(tmp[10].x,tmp[10].y);
     for i:=1 to 10 do
     begin
     Image1.Canvas.LineTo(tmp[i].x,tmp[i].y);
     end;
  end;
      //belahketupat
      if objek=8 then
  begin
     m:=Image1.Width div 2;
     n:=Image1.Height ;
     Image1.Canvas.MoveTo(m,0);
     Image1.Canvas.LineTo(m,n);
     for i:=1 to 4 do
     begin
     tmp[i].x:=(o[i].x-(2*(o[i].x-m)));
     tmp[i].y:=o[i].y;
     end;
     Image1.Canvas.MoveTo(tmp[4].x,tmp[4].y);
     for i:=1 to 4 do
     begin
     Image1.Canvas.LineTo(tmp[i].x,tmp[i].y);
     end;
  end;
  //if cat=true then FloodFill(tob.x,tob.y,ColorDialog1.Color,Image1.Canvas.Pixels[tob.x,tob.y]);
end;

procedure TForm1.btCropClick(Sender: TObject);
begin
  cat:=false;
  garis:=false;
  pensil:=true;
  penghapus:=false;
  selectState := True;
end;

procedure TForm1.btSegilimaClick(Sender: TObject);
begin
  //segilima
  penghapus:=false;
  pensil:=False;
  cat:=False;
  objek:=4; titik:=6;
  o[1].x:=100;    o[1].y:=50;
  o[2].x:=50;    o[2].y:=90;
  o[3].x:=65;    o[3].y:=150;
  o[4].x:=135;    o[4].y:=150;
  o[5].x:=150;    o[5].y:=90;
  o[6].x:=100;    o[6].y:=50;
  TitikTengah(Sender);
  FormShow(Sender);
end;

procedure TForm1.btTrapesiumClick(Sender: TObject);
begin
  penghapus:=false;
  pensil:=False;
  cat:=False;
  objek:=5; titik:=5;
  o[1].x:=75; o[1].y:=50;
  o[2].x:=175; o[2].y:=50;
  o[3].x:=225; o[3].y:=150;
  o[4].x:=25; o[4].y:=150;
  o[5].x:=75; o[5].y:=50;
  TitikTengah(Sender);
  FormShow(Sender);
end;

procedure TForm1.SpeedButton4Click(Sender: TObject);
begin
  cat:=true;
  garis:=false;
  pensil:=false;
  penghapus:=false;
  ColorDialog1.Execute;
end;

procedure TForm1.btGarisClick(Sender: TObject);
begin
  cat:=false;
  garis:=true;
  pensil:=false;
  penghapus:=false;
end;

procedure TForm1.btPenghapusClick(Sender: TObject);
begin
  cat:=false;
  garis:=false;
  pensil:=false;
  penghapus:=true;
end;

procedure TForm1.btHexagonClick(Sender: TObject);
begin
  //hexagon
   penghapus:=false;
  pensil:=False;
  cat:=False;
  objek:=6; titik:=7;
  o[1].x:=125;    o[1].y:=50;
  o[2].x:=50;    o[2].y:=100;
  o[3].x:=50;    o[3].y:=150;
  o[4].x:=125;    o[4].y:=200;
  o[5].x:=200;    o[5].y:=150;
  o[6].x:=200;    o[6].y:=100;
  o[7].x:=125;    o[7].y:=50;
  TitikTengah(Sender);
  FormShow(Sender);
end;

procedure TForm1.btSegi3Click(Sender: TObject);
begin
  //Bintang
  penghapus:=false;
  pensil:=False;
  cat:=False;
  objek:=7; titik:=10;
  o[1].x:=145;    o[1].y:=30;
  o[2].x:=120;    o[2].y:=120;
  o[3].x:=30;    o[3].y:=120;
  o[4].x:=100;    o[4].y:=170;
  o[5].x:=70;    o[5].y:=260;
  o[6].x:=145;    o[6].y:=210;
  o[7].x:=220;    o[7].y:=260;
  o[8].x:=190;    o[8].y:=170;
  o[9].x:=260;    o[9].y:=120;
  o[10].x:=170;    o[10].y:=120;
  TitikTengah(Sender);
  FormShow(Sender);
end;

procedure TForm1.btBelahKetupatClick(Sender: TObject);
begin
  penghapus:=false;
  pensil:=False;
  cat:=False;
  objek:=8; titik:=4;
  o[1].x:=100;    o[1].y:=50;
  o[2].x:=50;    o[2].y:=100;
  o[3].x:=100;    o[3].y:=150;
  o[4].x:=150;    o[4].y:=100;
  TitikTengah(Sender);
  FormShow(Sender);
end;

end.

