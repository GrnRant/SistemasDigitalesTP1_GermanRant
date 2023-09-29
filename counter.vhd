--Contador de un segundo
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity counter is
    --Para simulaciones se setea a N := 6 y a M := 49 y es un contador un microsegundo)
    generic(N: natural := 26; M: integer := 49999999);

    port (ena: in std_logic;
          clk: in std_logic;  
          rst: in std_logic;
          qo: out std_logic_vector(N-1 downto 0);
          max: out std_logic := '0'
          );
end counter;

architecture counter_beh of counter is
    signal aux: unsigned(N-1 downto 0);
begin
    process(clk, rst)
    begin
        if rst = '1' then
            aux <= (others => '0');
            max <= '0';
        end if;
        if rising_edge(clk) then
            --Si está habilitado
            if ena = '1' then
                --Sumar
                aux <= aux + 1;
                --Si se pasó poner en cero 
                if aux = to_unsigned(M, N) then
                    aux <= (others =>'0');
                    max <= '1';
                else
                    max <= '0';
                end if;
            end if;
            qo <= std_logic_vector(aux); 
        end if;
    end process;
end counter_beh;