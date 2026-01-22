-- para saber si la manzana y la persona chocan o no chocan
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Comparador is
    port (
        rst: in std_logic;
        clk: in std_logic;
        posicion_persona: in std_logic_vector(14 downto 0);
        posicion_manzana: in std_logic_vector(14 downto 0);
        no_atrapa: out std_logic;
        atrapa: out std_logic    
 );
end comparador;

architecture Behavioral of comparador is
begin

  process (clk,rst)
    variable choque : std_logic;
begin
    if rst = '0' then
        atrapa <= '0';
        no_atrapa <= '0';
        
    elsif rising_edge(clk) then  
        atrapa <= '0';
        no_atrapa <= '0';
        choque := '0';

        for i in 0 to 14 loop
            if (posicion_persona(i) = '1') and (posicion_manzana(i) = '1') then
                choque := '1';
            end if;
        end loop;
        if posicion_manzana(3) = '1' then
            if choque = '1' then
                atrapa <= '1';
            else
                no_atrapa <= '1';
            end if;
        end if;
    end if;
end process;

end Behavioral;
  