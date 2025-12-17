library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity persona is
Port (
        clk: in  std_logic;
        reset: in  std_logic;
        btn_left: in  std_logic;
        btn_right: in  std_logic;
        posicion: out std_logic_vector(14 downto 0)
    );
end persona;

architecture Behavioral of persona is

begin


end Behavioral;
