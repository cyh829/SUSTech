`timescale 1ns / 1ps

module cache(
    input CLK,
    input RESET,
    input MemWrite,
    input MemRead,
    input MenReady,
    input UpdateReady,
    input [31:0] ALUResult,
    input [31:0] WriteData,
    input [31:0] MenData,
    
    output [31:0] ReadData,
    output [31:0] LoadMemAddress,
    output reg [31:0] DataToMen,
    output reg [31:0] DataToMenAddress,
    output reg LoadMen,
    output reg UpdateMem,
    output busy
    );
    
    assign LoadMemAddress = ALUResult;
    
    reg [31:0] data1 [0:255];
    reg [31:0] data2 [0:255];
    reg [31:0] data3 [0:255];
    reg [31:0] data4 [0:255];
    
    reg [21:0] tag1 [0:255];
    reg [21:0] tag2 [0:255];
    reg [21:0] tag3 [0:255];
    reg [21:0] tag4 [0:255];
    
    reg V1 [0:255];
    reg V2 [0:255];
    reg V3 [0:255];
    reg V4 [0:255];
    
    reg D1 [0:255];
    reg D2 [0:255];
    reg D3 [0:255];
    reg D4 [0:255];
    
    reg [1:0] currentCache;
    
    integer i;
    
    initial begin
        for(i = 0; i < 256; i = i+1) begin 
            data1[i] = 32'h0;
            data2[i] = 32'h0;
            data3[i] = 32'h0;
            data4[i] = 32'h0;
            
            tag1[i] = 22'h0;
            tag2[i] = 22'h0;
            tag3[i] = 22'h0;
            tag4[i] = 22'h0;
            
            V1[i] = 0;
            V2[i] = 0;
            V3[i] = 0;
            V4[i] = 0;
            
            D1[i] = 0;
            D2[i] = 0;
            D3[i] = 0;
            D4[i] = 0;
        end
        currentCache = 2'b0;
    end
    
    reg readHit = 0;
    reg readBusy = 0;
    reg loadStart = 0;
    reg readStop = 1;
    reg [1:0] count = 0;
    reg writeMen =0;
    reg dirWrite = 0;
    reg checkV = 0;
    assign ReadData =  currentCache[1]?(currentCache[0]? data4[ALUResult[9:2]] :data3[ALUResult[9:2]]  )
                                               :(currentCache[0]? data2[ALUResult[9:2]] :data1[ALUResult[9:2]]  );
                                         

                                                
                                     
    
    always@(posedge CLK) begin
        if(MemRead && (!readStop))begin
            dirWrite = 0;
            checkV = 0;
            case(currentCache)
                2'b00: begin
                    if(tag1[ALUResult[9:2]]==ALUResult[31:10]&& V1[ALUResult[9:2]]) begin
                        readHit = 1;
                        readBusy = 0;
                        currentCache = currentCache;
                        count = 2'b00;
                        loadStart = 0;  
                        readStop = 1;       
                        writeMen = 0;
                    end
                    else begin
                        readBusy = 1;
                        
                        if(count == 2'b11) begin
                            readHit = 0;
                            currentCache = currentCache;
                            count = 2'b00;  
                            loadStart = 1;
                            readStop = 1; 
                            if ( D1[ALUResult[9:2]] ==  1) begin
                                writeMen = 1;
                                DataToMen = data1[ALUResult[9:2]];
                                DataToMenAddress = {tag1[ALUResult[9:2]],ALUResult[9:2],2'b00};
                            end           
                            else begin
                                writeMen = 0;
                            end                           
                        end
                        else begin
                            readHit = 0;
                            currentCache = currentCache + 2'b01;
                            count = count + 2'b01;
                            loadStart = 0;
                            readStop = 0; 
                        end
                    end
                end
                2'b01: begin
                    if(tag2[ALUResult[9:2]]==ALUResult[31:10]&& V2[ALUResult[9:2]]) begin
                        readHit = 1;
                        readBusy = 0;
                        currentCache = currentCache;
                        count = 2'b00; 
                        loadStart = 0;   
                        readStop = 1;  
                        writeMen = 0;                             
                    end
                    else begin
                        readBusy = 1;
                        
                        if(count == 2'b11) begin
                            readHit = 0;
                            currentCache = currentCache;
                            count = 2'b00;
                            loadStart = 1;  
                            readStop = 1; 
                            if ( D2[ALUResult[9:2]] ==  1) begin
                                writeMen = 1;
                                DataToMen = data2[ALUResult[9:2]];
                                DataToMenAddress = {tag2[ALUResult[9:2]],ALUResult[9:2],2'b00};
                            end           
                            else begin
                                writeMen = 0;
                            end  
                        end
                        else begin
                            readHit = 0;
                            currentCache = currentCache + 2'b01;
                            count = count + 2'b01;
                            loadStart = 0;
                            readStop = 0; 
                            writeMen = 0;
                        end
                    end
                end
                2'b10: begin
                    if(tag3[ALUResult[9:2]]==ALUResult[31:10]&& V3[ALUResult[9:2]]) begin
                        readHit = 1;
                        readBusy = 0;
                        currentCache = currentCache;
                        count = 2'b00;    
                        loadStart = 0; 
                        readStop = 1; 
                        writeMen = 0;                                           
                    end
                    else begin
                        readBusy = 1;
                        
                        if(count == 2'b11) begin
                            readHit = 0;
                            currentCache = currentCache;
                            count = 2'b00;  
                            loadStart = 1;
                            readStop = 1;
                            if ( D3[ALUResult[9:2]] ==  1) begin
                                writeMen = 1;
                                DataToMen = data3[ALUResult[9:2]];
                                DataToMenAddress = {tag3[ALUResult[9:2]],ALUResult[9:2],2'b00};
                            end           
                            else begin
                                writeMen = 0;
                            end                              
                        end
                        else begin
                            readHit = 0;
                            currentCache = currentCache + 2'b01;
                            count = count + 2'b01;
                            loadStart = 0;
                            readStop = 0; 
                            writeMen = 0;
                        end
                    end
                end  
                2'b11: begin
                    if(tag4[ALUResult[9:2]]==ALUResult[31:10]&& V4[ALUResult[9:2]]) begin
                        readHit = 1;
                        readBusy = 0;
                        currentCache = currentCache;
                        count = 2'b00;     
                        loadStart = 0;     
                        readStop = 1;    
                        writeMen = 0;           
                    end
                    else begin
                        readBusy = 1;
                        
                        if(count == 2'b11) begin
                            readHit = 0;
                            currentCache = currentCache;
                            count = 2'b00;  
                            loadStart = 1;
                            readStop = 1; 
                            if ( D4[ALUResult[9:2]] ==  1) begin
                                writeMen = 1;
                                DataToMen = data4[ALUResult[9:2]];
                                DataToMenAddress = {tag4[ALUResult[9:2]],ALUResult[9:2],2'b00};
                            end           
                            else begin
                                writeMen = 0;
                            end  
                        end
                        else begin
                            readHit = 0;
                            currentCache = currentCache + 2'b01;
                            count = count + 2'b01;
                            loadStart = 0;
                            readStop = 0; 
                            writeMen = 0;
                        end
                    end
                end                              
            endcase
        end
        else if(MemRead && readStop) begin
            dirWrite = 0;
            checkV = 0;
            if(busy&&(!hold)) begin
                readHit = readHit;
                readBusy = 0;
                currentCache = currentCache;
                count = count;     
                loadStart = 0;     
                readStop = readStop;   
                writeMen = 0;           
            end
            else begin
                readHit = readHit;
                readBusy = 1;
                currentCache = currentCache;
                count = count;     
                loadStart = 0;     
                readStop = 0;          
                writeMen = 0;        
            end
        end
        else if(MemWrite && (!readStop)) begin  
            loadStart = 0;     
            case(currentCache)
                2'b00: begin
                    if(tag1[ALUResult[9:2]]==ALUResult[31:10]) begin
                        checkV = 0;
                        if(D1[ALUResult[9:2]] ==  0)begin
                            readHit = 1;
                            readBusy = 0;
                            currentCache = currentCache;
                            count = 2'b00;   
                            readStop = 1;
                            writeMen = 0;     
                            dirWrite = 1;                     
                        end
                        else begin
                            readHit = 1;
                            readBusy = 0;
                            currentCache = currentCache;
                            count = 2'b00;
                            readStop = 1;
                            writeMen = 1;
                            DataToMen = data1[ALUResult[9:2]];  
                            DataToMenAddress = {tag1[ALUResult[9:2]],ALUResult[9:2],2'b00};  
                            dirWrite = 1;                     
                        end
                    end
                    else begin
                        if((count == 2'b11) && (checkV == 0))begin
                            readHit = 0;
                            readBusy = 1;
                            currentCache = currentCache + 2'b01;
                            count = 2'b00;   
                            readStop = 0;
                            writeMen = 0;     
                            dirWrite = 0;     
                            checkV = 1;                        
                        end
                        else if((count == 2'b11) && (checkV == 1)) begin
                            if (D1[ALUResult[9:2]] ==  0)begin
                                readHit = 0;
                                readBusy = 0;
                                currentCache = currentCache;
                                count = 2'b00;   
                                readStop = 1;
                                writeMen = 0;     
                                dirWrite = 1;     
                                checkV = 0;                                 
                            end
                            else begin
                                readHit = 0;
                                readBusy = 0;
                                currentCache = currentCache;
                                count = 2'b00;   
                                readStop = 1;
                                writeMen = 1;    
                                DataToMen = data1[ALUResult[9:2]]; 
                                DataToMenAddress = {tag1[ALUResult[9:2]],ALUResult[9:2],2'b00};
                                dirWrite = 1;     
                                checkV = 0;                                
                            end
                        end
                        else if((count != 2'b11) && (checkV == 0)) begin
                            readHit = 0;
                            readBusy = 1;
                            currentCache = currentCache + 2'b01;
                            count = count + 2'b01;   
                            readStop = 0;
                            writeMen = 0;     
                            dirWrite = 0;     
                            checkV = checkV;                              
                        end
                        else if((count != 2'b11) && (checkV == 1)) begin
                            if(V1[ALUResult[9:2]])begin
                                readHit = 0;
                                readBusy = 1;
                                currentCache = currentCache + 2'b01;
                                count = count + 2'b01;   
                                readStop = 0;
                                writeMen = 0;     
                                dirWrite = 0;     
                                checkV = checkV;                                
                            end
                            else begin
                                readHit = 0;
                                readBusy = 0;
                                currentCache = currentCache;
                                count =  2'b00;   
                                readStop = 1;
                                writeMen = 0;     
                                dirWrite = 1;     
                                checkV = 0;                              
                            end
                        end
                    end
                end
                2'b01: begin
                    if(tag2[ALUResult[9:2]]==ALUResult[31:10]) begin
                        checkV = 0;
                        if(D2[ALUResult[9:2]] ==  0)begin
                            readHit = 1;
                            readBusy = 0;
                            currentCache = currentCache;
                            count = 2'b00;   
                            readStop = 1;
                            writeMen = 0;     
                            dirWrite = 1;                     
                        end
                        else begin
                            readHit = 1;
                            readBusy = 0;
                            currentCache = currentCache;
                            count = 2'b00;
                            readStop = 1;
                            writeMen = 1;
                            DataToMen = data2[ALUResult[9:2]];    
                            DataToMenAddress = {tag2[ALUResult[9:2]],ALUResult[9:2],2'b00};
                            dirWrite = 1;                     
                        end
                    end
                    else begin
                        if((count == 2'b11) && (checkV == 0))begin
                            readHit = 0;
                            readBusy = 1;
                            currentCache = currentCache + 2'b01;
                            count = 2'b00;   
                            readStop = 0;
                            writeMen = 0;     
                            dirWrite = 0;     
                            checkV = 1;                        
                        end
                        else if((count == 2'b11) && (checkV == 1)) begin
                            if (D2[ALUResult[9:2]] ==  0)begin
                                readHit = 0;
                                readBusy = 0;
                                currentCache = currentCache;
                                count = 2'b00;   
                                readStop = 1;
                                writeMen = 0;     
                                dirWrite = 1;     
                                checkV = 0;                                 
                            end
                            else begin
                                readHit = 0;
                                readBusy = 0;
                                currentCache = currentCache;
                                count = 2'b00;   
                                readStop = 1;
                                writeMen = 1;    
                                DataToMen = data2[ALUResult[9:2]]; 
                                DataToMenAddress = {tag2[ALUResult[9:2]],ALUResult[9:2],2'b00};
                                dirWrite = 1;     
                                checkV = 0;                                
                            end
                        end
                        else if((count != 2'b11) && (checkV == 0)) begin
                                readHit = 0;
                                readBusy = 1;
                                currentCache = currentCache + 2'b01;
                                count = count + 2'b01;   
                                readStop = 0;
                                writeMen = 0;     
                                dirWrite = 0;     
                                checkV = checkV;                              
                        end
                        else if((count != 2'b11) && (checkV == 1)) begin
                            if(V2[ALUResult[9:2]])begin
                                readHit = 0;
                                readBusy = 1;
                                currentCache = currentCache + 2'b01;
                                count = count + 2'b01;   
                                readStop = 0;
                                writeMen = 0;     
                                dirWrite = 0;     
                                checkV = checkV;                                
                            end
                            else begin
                                readHit = 0;
                                readBusy = 0;
                                currentCache = currentCache;
                                count =  2'b00;   
                                readStop = 1;
                                writeMen = 0;     
                                dirWrite = 1;     
                                checkV = 0;                              
                                end
                            end
                        end
                    end
                    2'b10: begin
                        if(tag3[ALUResult[9:2]]==ALUResult[31:10]) begin
                            checkV = 0;
                            if(D3[ALUResult[9:2]] ==  0)begin
                                readHit = 1;
                                readBusy = 0;
                                currentCache = currentCache;
                                count = 2'b00;   
                                readStop = 1;
                                writeMen = 0;     
                                dirWrite = 1;                     
                            end
                            else begin
                                readHit = 1;
                                readBusy = 0;
                                currentCache = currentCache;
                                count = 2'b00;
                                readStop = 1;
                                writeMen = 1;
                                DataToMen = data3[ALUResult[9:2]]; 
                                DataToMenAddress = {tag3[ALUResult[9:2]],ALUResult[9:2],2'b00};   
                                dirWrite = 1;                     
                                end
                            end
                            else begin
                            if((count == 2'b11) && (checkV == 0))begin
                                readHit = 0;
                                readBusy = 1;
                                currentCache = currentCache + 2'b01;
                                count = 2'b00;   
                                readStop = 0;
                                writeMen = 0;     
                                dirWrite = 0;     
                                checkV = 1;                        
                            end
                            else if((count == 2'b11) && (checkV == 1)) begin
                                if (D3[ALUResult[9:2]] ==  0)begin
                                    readHit = 0;
                                    readBusy = 0;
                                    currentCache = currentCache;
                                    count = 2'b00;   
                                    readStop = 1;
                                    writeMen = 0;     
                                    dirWrite = 1;     
                                    checkV = 0;                                 
                                end
                                else begin
                                    readHit = 0;
                                    readBusy = 0;
                                    currentCache = currentCache;
                                    count = 2'b00;   
                                    readStop = 1;
                                    writeMen = 1;    
                                    DataToMen = data3[ALUResult[9:2]];
                                    DataToMenAddress = {tag3[ALUResult[9:2]],ALUResult[9:2],2'b00}; 
                                    dirWrite = 1;     
                                    checkV = 0;                                
                                end
                            end
                            else if((count != 2'b11) && (checkV == 0)) begin
                                readHit = 0;
                                readBusy = 1;
                                currentCache = currentCache + 2'b01;
                                count = count + 2'b01;   
                                readStop = 0;
                                writeMen = 0;     
                                dirWrite = 0;     
                                checkV = checkV;                              
                            end
                            else if((count != 2'b11) && (checkV == 1)) begin
                                if(V3[ALUResult[9:2]])begin
                                    readHit = 0;
                                    readBusy = 1;
                                    currentCache = currentCache + 2'b01;
                                    count = count + 2'b01;   
                                    readStop = 0;
                                    writeMen = 0;     
                                    dirWrite = 0;     
                                    checkV = checkV;                                
                                end
                                else begin
                                    readHit = 0;
                                    readBusy = 0;
                                    currentCache = currentCache;
                                    count =  2'b00;   
                                    readStop = 1;
                                    writeMen = 0;     
                                    dirWrite = 1;     
                                    checkV = 0;                              
                                end
                            end
                        end
                    end
                    2'b11: begin
                        if(tag4[ALUResult[9:2]]==ALUResult[31:10]) begin
                            checkV = 0;
                            if(D4[ALUResult[9:2]] ==  0)begin
                                readHit = 1;
                                readBusy = 0;
                                currentCache = currentCache;
                                count = 2'b00;   
                                readStop = 1;
                                writeMen = 0;     
                                dirWrite = 1;                     
                            end
                            else begin
                                readHit = 1;
                                readBusy = 0;
                                currentCache = currentCache;
                                count = 2'b00;
                                readStop = 1;
                                writeMen = 1;
                                DataToMen = data4[ALUResult[9:2]]; 
                                DataToMenAddress = {tag4[ALUResult[9:2]],ALUResult[9:2],2'b00};   
                                dirWrite = 1;                     
                            end
                        end
                        else begin
                            if((count == 2'b11) && (checkV == 0))begin
                                readHit = 0;
                                readBusy = 1;
                                currentCache = currentCache + 2'b01;
                                count = 2'b00;   
                                readStop = 0;
                                writeMen = 0;     
                                dirWrite = 0;     
                                checkV = 1;                        
                            end
                            else if((count == 2'b11) && (checkV == 1)) begin
                                if (D4[ALUResult[9:2]] ==  0)begin
                                    readHit = 0;
                                    readBusy = 0;
                                    currentCache = currentCache;
                                    count = 2'b00;   
                                    readStop = 1;
                                    writeMen = 0;     
                                    dirWrite = 1;     
                                    checkV = 0;                                 
                                end
                                else begin
                                    readHit = 0;
                                    readBusy = 0;
                                    currentCache = currentCache;
                                    count = 2'b00;   
                                    readStop = 1;
                                    writeMen = 1;    
                                    DataToMen = data4[ALUResult[9:2]]; 
                                    DataToMenAddress = {tag4[ALUResult[9:2]],ALUResult[9:2],2'b00};
                                    dirWrite = 1;     
                                    checkV = 0;                                
                                end
                            end
                            else if((count != 2'b11) && (checkV == 0)) begin
                                readHit = 0;
                                readBusy = 1;
                                currentCache = currentCache + 2'b01;
                                count = count + 2'b01;   
                                readStop = 0;
                                writeMen = 0;     
                                dirWrite = 0;     
                                checkV = checkV;                              
                            end
                            else if((count != 2'b11) && (checkV == 1)) begin
                                if(V4[ALUResult[9:2]])begin
                                    readHit = 0;
                                    readBusy = 1;
                                    currentCache = currentCache + 2'b01;
                                    count = count + 2'b01;   
                                    readStop = 0;
                                    writeMen = 0;     
                                    dirWrite = 0;     
                                    checkV = checkV;                                
                                end
                                else begin
                                    readHit = 0;
                                    readBusy = 0;
                                    currentCache = currentCache;
                                    count =  2'b00;   
                                    readStop = 1;
                                    writeMen = 0;     
                                    dirWrite = 1;     
                                    checkV = 0;                              
                                end
                            end
                        end
                    end
            endcase     
        end
        else if(MemWrite && readStop) begin
            dirWrite = 0;
            checkV = 0;
            if(busy&&(!hold)) begin
                readHit = readHit;
                readBusy = 0;
                currentCache = currentCache;
                count = count;     
                loadStart = 0;     
                readStop = readStop;   
                writeMen = 0;           
            end
            else begin
                readHit = readHit;
                readBusy = 1;
                currentCache = currentCache;
                count = count;     
                loadStart = 0;     
                readStop = 0;          
                writeMen = 0;        
            end
        end
    end
    
    reg loadStop = 1;
    reg loadBusy = 0;
    reg writeStart = 0;
    
    always@(negedge CLK) begin
        if(MemRead && (!loadStop))begin
            if(MenReady)begin
                loadStop = 1;
                loadBusy = 0;
                LoadMen = 0;
                writeStart = 1;
            end
            else begin
                loadStop = 0;
                loadBusy = 1;
                LoadMen = 1;
                writeStart = 0;
            end
        end
        else if(MemRead && (loadStop) )begin
            if(busy && loadStart) begin
                loadStop = 0;
                loadBusy = 1;
                LoadMen = 1;
                writeStart = 0;
            end
            else begin
                 loadStop = 1;
                 loadBusy = loadBusy;
                 LoadMen = 0;
                 writeStart = 0;
            end
        end
    end
    
    
    
    always@(posedge writeStart or posedge dirWrite or posedge RESET) begin
        if(RESET) begin
            for(i = 0; i < 256; i = i+1) begin 
                    data1[i] = 32'h0;
                    data2[i] = 32'h0;
                    data3[i] = 32'h0;
                    data4[i] = 32'h0;
                    
                    tag1[i] = 22'h0;
                    tag2[i] = 22'h0;
                    tag3[i] = 22'h0;
                    tag4[i] = 22'h0;
                    
                    V1[i] = 0;
                    V2[i] = 0;
                    V3[i] = 0;
                    V4[i] = 0;
                    
                    D1[i] = 0;
                    D2[i] = 0;
                    D3[i] = 0;
                    D4[i] = 0;
                end
        end
        else if(MemRead && writeStart)begin
            case(currentCache)
                2'b00: begin
                    tag1[ALUResult[9:2]] = ALUResult[31:10];
                    data1[ALUResult[9:2]] = MenData[31:0];
                    V1[ALUResult[9:2]] = 1;
                    D1[ALUResult[9:2]] = 0;
                end
                2'b01: begin
                    tag2[ALUResult[9:2]] = ALUResult[31:10];
                    data2[ALUResult[9:2]] = MenData[31:0];
                    V2[ALUResult[9:2]] = 1;
                    D2[ALUResult[9:2]] = 0;
                end
                2'b10: begin
                    tag3[ALUResult[9:2]] = ALUResult[31:10];
                    data3[ALUResult[9:2]] = MenData[31:0];
                    V3[ALUResult[9:2]] = 1;
                    D3[ALUResult[9:2]] = 0;
                end
                2'b11: begin
                    tag4[ALUResult[9:2]] = ALUResult[31:10];
                    data4[ALUResult[9:2]] = MenData[31:0];
                    V4[ALUResult[9:2]] = 1;
                    D4[ALUResult[9:2]] = 0;
                end                                
            endcase
        end
        else if(MemWrite && dirWrite) begin
            case(currentCache)
                2'b00: begin
                    tag1[ALUResult[9:2]] = ALUResult[31:10];
                    data1[ALUResult[9:2]] = WriteData[31:0];
                    V1[ALUResult[9:2]] = 1;
                    D1[ALUResult[9:2]] = 1;
                end
                2'b01: begin
                    tag2[ALUResult[9:2]] = ALUResult[31:10];
                    data2[ALUResult[9:2]] = WriteData[31:0];
                    V2[ALUResult[9:2]] = 1;
                    D2[ALUResult[9:2]] = 1;
                end
                2'b10: begin
                    tag3[ALUResult[9:2]] = ALUResult[31:10];
                    data3[ALUResult[9:2]] = WriteData[31:0];
                    V3[ALUResult[9:2]] = 1;
                    D3[ALUResult[9:2]] = 1;
                end
                2'b11: begin
                    tag4[ALUResult[9:2]] = ALUResult[31:10];
                    data4[ALUResult[9:2]] = WriteData[31:0];
                    V4[ALUResult[9:2]] = 1;
                    D4[ALUResult[9:2]] = 1;
                end
            endcase        
        end
    end

    always@(negedge CLK) begin
        if(writeMen) begin
            UpdateMem =1;
        end
        else if(UpdateReady) begin
            UpdateMem =0;
        end
        else begin
            UpdateMem = UpdateMem;
        end
    end
    
    reg hold =0;
     always@(posedge MemWrite or posedge MemRead or posedge readBusy) begin
        if(readBusy)begin
            hold = 0;
        end
        else if (MemWrite || MemRead)  begin
            hold = 1;
        end
        else begin
            hold = hold;
        end
     end
    
    assign busy = ((readBusy || loadBusy || writeStart)&&(MemWrite || MemRead)) || hold;
    
    
endmodule
