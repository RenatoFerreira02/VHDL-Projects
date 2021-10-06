--! Projeto de Memória ROM com dados lidos de um arquivo

library ieee;
USE ieee.numeric_std.all;
use ieee.numeric_bit.all;
use std.textio.all;

entity rom_arquivo is
    port(
    addr: in bit_vector(4 downto 0);
    data: out bit_vector(7 downto 0)
);
end rom_arquivo;

architecture arquivo_arch of rom_arquivo is

type mem_tipo is array (0 to 31) of bit_vector(7 downto 0);

impure function init_mem(nome_do_arquivo : in string) return mem_tipo is
    file     arquivo  : text open read_mode is nome_do_arquivo;
    variable linha    : line;
    variable temp_bv  : bit_vector(7 downto 0);
    variable temp_mem : mem_tipo;
    begin
      
      for i in mem_tipo'range loop
        
        readline(arquivo, linha);
        
        read(linha, temp_bv);
        
        temp_mem(i) := temp_bv;
      end loop;
      return temp_mem;
    end;
  --! Delaracao da matriz de memoria em si 
  constant mem : mem_tipo := init_mem("conteudo_rom_ativ_02_carga.dat");
begin
  data <= mem(to_integer(unsigned(addr)));

end arquivo_arch;
