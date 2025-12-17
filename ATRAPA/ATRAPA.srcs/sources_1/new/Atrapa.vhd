library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity atrapa is
    Port (
        CLK : in  std_logic;
        Button_LEFT : in  std_logic;
        Button_RIGHT : in  std_logic;
        rst : in  std_logic;
        Luces : out std_logic_vector(14 downto 0)
    );
end atrapa;

architecture Behavioral of atrapa is
signal pos_persona : std_logic_vector(14 downto 0);

Component persona is
    Port (
        clk: in  std_logic;
        btn_left: in  std_logic;
        btn_right: in  std_logic;
        reset: in  std_logic;
        posicion: out std_logic_vector(14 downto 0)
    );
    
end component;
begin
INST_persona: persona Port MAP (
    clk=>clk,
    BTN_LEFT => Button_LEFT,   
    BTN_RIGHT=> button_RIGHT,
    reset=> rst,
    posicion=> pos_persona
);


end Behavioral;