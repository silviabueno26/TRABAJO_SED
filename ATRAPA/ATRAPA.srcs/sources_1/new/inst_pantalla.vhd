library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity pantalla is
Port ( 
        clk: in std_logic;
        reset: in std_logic;
        posicion_pantalla :  out std_logic_vector(14 downto 0);
        level1: in STD_LOGIC;
        level2: in STD_LOGIC;
        level3: in STD_LOGIC;
        win: out std_logic
        
);
end pantalla;

architecture Behavioral of pantalla is

signal sync_i:std_logic;
signal edge_i:std_logic;
signal sync1_i:std_logic;
signal edge1_i:std_logic;
signal sync2_i:std_logic;
signal edge2_i:std_logic;

COMPONENT SYNCHRNZR_level1
 PORT( 
    CLK: IN std_logic;
    ASYNC_IN_l1: IN std_logic;
    SYNC_OUT_l1: OUT std_logic
);
END COMPONENT;    
    
COMPONENT SYNCHRNZR_level2
 PORT( 
    CLK: IN std_logic;
    ASYNC_IN_l2: IN std_logic;
    SYNC_OUT_l2: OUT std_logic
);
END COMPONENT;    

COMPONENT SYNCHRNZR_level3
 PORT( 
    CLK: IN std_logic;
    ASYNC_IN_l3: IN std_logic;
    SYNC_OUT_l3: OUT std_logic
);
END COMPONENT;   

COMPONENT EDGEDTCTR_level1
PORT( 
    CLK: IN std_logic;
    SYNC_IN_l1: IN std_logic;
    EDGEl1: OUT std_logic
);
END COMPONENT; 
    
COMPONENT EDGEDTCTR_level2
PORT( 
    CLK: IN std_logic;
    SYNC_IN_l2: IN std_logic;
    EDGEl2: OUT std_logic
);
END COMPONENT; 
    
COMPONENT EDGEDTCTR_level3
PORT( 
    CLK: IN std_logic;
    SYNC_IN_l3: IN std_logic;
    EDGEl3: OUT std_logic
);
END COMPONENT;  

Component pantalla_principal
Port(
        clk: in  std_logic;         
        reset: in  std_logic;          
        level1:in std_logic;
        level2:in std_logic;
        level3:in std_logic;
        posicion_pantalla: out std_logic_vector(14 downto 0); 
        win: out STD_LOGIC
); 
end component;

begin
Inst_SYNCHRNZR_level1: SYNCHRNZR_level1 
PORT MAP(
        CLK=>CLK,
        ASYNC_IN_l1=>level1,
        SYNC_OUT_l1=>sync_i
);
    
Inst_SYNCHRNZR_level2: SYNCHRNZR_level2 
PORT MAP(
        CLK=>CLK,
        ASYNC_IN_l2=>level2,
        SYNC_OUT_l2=>sync1_i
);

Inst_SYNCHRNZR_level3: SYNCHRNZR_level3 
PORT MAP(
        CLK=>CLK,
        ASYNC_IN_l3=>level3,
        SYNC_OUT_l3=>sync2_i
); 

Inst_EDGEDTCTR_level1: EDGEDTCTR_level1 
PORT MAP(
       CLK=>CLK,
        SYNC_IN_l1=>sync_i,
        EDGEl1=>edge_i
);

Inst_EDGEDTCTR_level2: EDGEDTCTR_level2 
PORT MAP(
        CLK=>CLK,
        SYNC_IN_l2=>sync1_i,
        EDGEl2=>edge1_i
);
    
Inst_EDGEDTCTR_level3: EDGEDTCTR_level3 
PORT MAP(
        CLK=>CLK,
        SYNC_IN_l3=>sync2_i,
        EDGEl3=>edge2_i
);


Inst_pantalla_principal: pantalla_principal
PORT MAP(
        clk=>clk,
        reset=>reset,
        level1=> level1,
        level2=>level2,
        level3=> level3,
        posicion_pantalla=>posicion_pantalla,
        win=> win
);

end Behavioral;