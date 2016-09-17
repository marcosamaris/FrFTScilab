
//exec 'C:\Archivos de programa\scilab-4.1.2\contrib\siptoolbox\loader.sce';
stacksize(3e7);
image=0;
// Crear Ventana
ventana=figure('backgroundColor', [255 255 255],'position', [50 50 600 400]);

// Crear radioboton
//uicontrol(ventana, 'backgroundColor', [255 255 255], 'style','radiobutton','string','Botón de Radio en la ventana', 'position',[400 300 200 20], 'fontsize',12);

menuArch=uimenu(ventana,'label', 'Archivo');
menuFir=uimenu(ventana,'label', 'Filtros FIR');
menuIir=uimenu(ventana,'label', 'Filtros IIR');
menuWiener=uimenu(ventana,'label', 'Filtros de Wiener');
menuTrans=uimenu(ventana, 'label', 'Transformaciones');
menuTeo=uimenu(ventana, 'label', 'Teoría');

menuHelp=uimenu(ventana, 'label', 'Ayuda');


// Menu Archivo
smenuArch1=uimenu(menuArch, 'label', 'abrir_image', 'label', 'Abrir Imagen', 'callback','image=leer_imagen()');
smenuArch3=uimenu(menuArch,'label', 'Guardar', 'callback', "");
smenuArch2=uimenu(menuArch,'label', 'Salir', 'callback', "close(x)");


// Menu Filtros FIR
smenuFir1=uimenu(menuFir,'label', 'menu1');
smenuFir2=uimenu(menuFir,'label', 'menu2');

// Menu Filtros IIR
smenuIir1=uimenu(menuIir,'label', 'menu1');
smenuIir2=uimenu(menuIir,'label', 'menu2');

// Menu Filtros Wiener
smenuWie1=uimenu(menuWiener,'label', 'Filtro de Wiener');
smenuWie2=uimenu(menuWiener,'label', 'Filtro de Wiener fraccionario');

// Menu Transformadas

smenuTra2=uimenu(menuTrans,'label', 'Transformación de Fourier','callback','image=transRapFourier(image)');
smenuTra3=uimenu(menuTrans,'label', 'Transformación de Fourier Inversa');
smenuTra3=uimenu(menuTrans,'label', 'Transformación de Fourier Inversa');

// Menu Teoría
smenuTeo1=uimenu(menuTeo,'label', 'menu1');
smenuTeo2=uimenu(menuTeo,'label', 'menu2');


// Menu Ayuda
//smenuHelp1=uimenu(menuHelp,'label', 'Manual de Usuario', 'callback',"exec ' manual.pdf';"); 
smenuHelp2=uimenu(menuHelp,'label', 'Acerca de...', 'callback',"acerca_de()");


function [image,map]=leer_imagen()
  imagen=xgetfile('*.jpg', title='Escoja una imagen');
   imfinfo(imagen,'verbose');
  [ima, map]=imread(imagen);
  xbasc(0);
  imshow(ima);
endfunction



function [image]=transRapFourier(image) 
  image=image(:)
  y=fft(image);
  xbasc(0);
  plot(y);

endfunction



function []=acerca_de()

  // Crear Ventana
  x=figure('backgroundColor', [245 245 245],'position', [100 100 300 200]);  
  // Escribir texto
  uicontrol(x, 'backgroundColor', [245 245 245], 'style','text','string','Este Programa fue desarrollado por:', 'position',[20 150 200 20], 'fontsize',12);
  uicontrol(x, 'backgroundColor', [245 245 245], 'style','text','string','Marcos Amaris Gonzalez', 'position',[20 100 200 20], 'fontsize',12);
  uicontrol(x, 'backgroundColor', [245 245 245], 'style','text','string','Dirigido por:', 'position',[20 40 200 20], 'fontsize',12);
  uicontrol(x, 'backgroundColor', [245 245 245], 'style','text','string','Dr. Rafael Angel Torres Amaris', 'position',[20 20 200 20], 'fontsize',12);
endfunction
