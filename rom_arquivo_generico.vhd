--! Memoria ROM genérica

library ieee;
use ieee.numeric_bit.ALL;
use std.textio.all;

entity rom_arquivo_generica is
  generic(
    addressSize   : natural := 5; 
    wordSize      : natural := 8; 
    datFileName : string  := "conteudo_rom_ativ_02_carga.dat"
  );
  port(
    addr : in  bit_vector(addressSize-1 downto 0);
    data : out bit_vector(wordSize-1 downto 0)
  );
end rom_arquivo_generica;

architecture generica_arch of rom_arquivo_generica is

  constant depth : natural := 2**addressSize;
  type mem_type is array (0 to depth-1) of bit_vector(wordSize-1 downto 0);
  
  impure function init_mem(fileName : in string) return mem_type is
    file     f       : text open read_mode is fileName;
    variable l       : line;
    variable tmp_bv  : bit_vector(wordSize-1 downto 0);
    variable tmp_mem : mem_type;
    
  begin
    for i in mem_type'range loop
      readline(f, l);
      read(l, tmp_bv);
      tmp_mem(i) := tmp_bv;
    end loop;
    return tmp_mem;
  end;
  
 
  constant mem : mem_type := init_mem(datFileName);
begin
  data <= mem(to_integer(unsigned(addr)));
end generica_arch;
