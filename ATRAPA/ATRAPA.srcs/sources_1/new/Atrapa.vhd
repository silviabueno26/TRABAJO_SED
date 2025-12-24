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
signal nivel1_act_s, nivel2_act_s, nivel3_act_s : std_logic;
signal manzanas: std_logic_vector (14 downto 0);
signal atrapa_s: std_logic;
signal decenas_s: std_logic_vector(3 downto 0);
signal unidades_s: std_logic_vector(3 downto 0);
signal game_over_s: std_logic;
signal win_s: std_logic;

Component persona is
    Port (
        clk: in  std_logic;
        btn_left: in  std_logic;
        btn_right: in  std_logic;
        reset: in  std_logic;
        posicion: out std_logic_vector(14 downto 0)
    );
    
end component;

Component manzana is
    Port (
        clk: in  std_logic;
        reset: in  std_logic;
        nivel1: in  std_logic;
        nivel2: in  std_logic;
        nivel3: in  std_logic;
        posicion_manzana: out std_logic_vector(14 downto 0)
    );
end component;

Component decoder is
    Port ( 
        clk: in std_logic;
        rst: in std_logic;
        posicion_persona: in std_logic_vector (14 downto 0);
        posicion_manzana: in std_logic_vector (14 downto 0);
        game_over : in std_logic;
        win: in std_logic;
        decenas  : in std_logic_vector(3 downto 0); 
        unidades : in std_logic_vector(3 downto 0); 
        leds: out std_logic_vector (14 downto 0)
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

INST_manzana : manzana port map (
    clk => clk,
    reset => rst,
    nivel1 => nivel1_act_s,
    nivel2 => nivel2_act_s,
    nivel3 => nivel3_act_s,
    posicion_manzana => manzanas
);

INST_decoder : decoder Port map (
    clk=> clk,
    rst=> rst,
    posicion_persona=> pos_persona,
    posicion_manzana=> manzanas,
    game_over => game_over_s,
    win=> win_s,
    decenas=> decenas_s,
    unidades => unidades_s,
    leds=> Luces
);


end Behavioral;