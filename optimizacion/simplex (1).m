function simplex(A, b, c, min_max, procedimiento)
sz_c = size(c);
sz_A = size(A);
sz_b = size(b);

if sz_c(1,2) == sz_A(1,2) & sz_c(1,1) == 1
    Dim = true;
    if sz_b(1,1) == sz_A(1,1) & sz_b(1,2) == 1
        Dim = true ;
    end
else
    Warning = "Dimensiones incorrectas !!!" 
    return
end

%Crea un vector fila con n 1's siendo n las variables artificiales
for i = 1:sz_A(1, 1)
    vec_iden(1, i) = 1;
end
Iden_Arti = diag(vec_iden); %Crea la matriz identidad

A_arti = [A, Iden_Arti];    %Nueva matriz A con las variables artificiales
sz_A_arti = size(A_arti);

%Crear un vector fila con m 0's siendo m las variables del problema
%original
for i = 1:sz_A(1, 2)
    vec_costo(1, i) = 0;
end
c_arti = [vec_costo, vec_iden];     %Vector de costos para las variables artificiales

b_tras = transpose(b); %Vector fila con los elementos de b

%Creación de vector IB de variables artificiales
j = 1;
for i = sz_A(1, 2) + 1:sz_A_arti(1, 2)
    IB_arti(1, j) = i;
    j = j + 1;
end
%Creación de vector IN de variables artificiales
for i = 1:sz_A(1, 2)
    IN_arti(1, i) = i;
end

%sol = false;

A_cop = A;
c_cop = c;

if min_max == "max"     %Si se maximiza se multiplican los costos por(-1) para tener un problema de minimización
    c_cop = -1.*c;
end

%Se guardan las variables principales con las variables arificiales ya
%incluidas
A = A_arti;
IB = IB_arti;
IN = IN_arti;
c = c_arti;



if procedimiento == "Si" %Verbose
    A               %Matriz A 
    IB              %Vector fila con índices básicos
    IN              %Vector fila con índices no básicos
    c               %Vector fila de costos
end
r = 0;
while true %sol == false  
    r = 1 + r;
    if procedimiento == "Si"
        Iteracion = r
    end
    
    %sz_ tamaño de la matriz
    sz_A = size(A);
    sz_IB = size(IB);
    sz_IN = size(IN);

    %Creación de la matriz B 
    for i = 1:sz_IB(1, 2)
        ind = IB(1, i);
        B(:, i) = A(:, ind);
    end     
    B_inv = inv(B);

    %Creación de la matriz N
    for i = 1:sz_IN(1, 2)
        N(:, i) = A(:, IN(1, i));
    end
    N;

    %Creación de XB, b barra
    XB = B_inv*b;
    ind_XB = transpose(IB);
    XB_tras = transpose(XB);
    
    %Vector X
    X_ = [];
    k9 = 1;
    for i = 1:length(c)
        [q] = find(i == IB);
        if isempty(q)
            X_(i, 1) = 0;
        else
            X_(IB(1, k9), 1) = XB_tras(1, k9);
            k9 = 1 + k9;
        end
    end
    X_;
     
    %Creación de cN_prim vector de costos no básicos
    for i = 1:sz_IN(1, 2)
        j = IN(1, i); 
        cN_prim(1, i) = c(1, j);
    end
    cN_prim;

    %Creación de cB_prim vector de costos básicos
    for i = 1:sz_IB(1, 2)
        j = IB(1, i); 
        cB_prim(1, i) = c(1, j);
    end    
    cB_prim;

    Zo = cB_prim*XB;

    
    %Creación de cN_ costos reducidos
    cN_ = cN_prim - ((cB_prim * B_inv) * N);
    sz_cN_ = size(cN_);

    may_cero = [];
    ind_may_cero = [];
    men_cero = [];
    ind_men_cero = [];
    j = 1;
    k = 1;
    for i = 1:sz_cN_(1, 2)
        if cN_(1, i) >= 0
            may_cero(1, j) = cN_(1, i);
            ind_may_cero(1, j) = IN(1, i);
            j = j + 1;
        else
            men_cero(1, k) = cN_(1, i);
            ind_men_cero(1, k) = IN(1, i);
            k = k + 1;

        end
    end
    
    if procedimiento == "Si"
        B
        B_inv
        XB
        X_
        Zo
        cN_
    end 
    
    may_cero;       %(mayores o iguales a 0)
    ind_may_cero;	%(indices de los mayores o iguales a 0)
    men_cero;       %(menores a 0)
    ind_men_cero;	%(indices de los menores o iguales a 0)
    
    %Si el tamaño de los mayores o iguales a 0 es igual a el tamaño de los costos 
    if length(may_cero) == length(cN_)
        if procedimiento == "Si"
            s = "La solución actual es óptima"
        end       
        IB;
        IN;
        cN_;
        ax_en_IB = [];
        k4 = 1;
        %revisa si hay artificiales en la base
        for i = 1:length(IB_arti)
            for j = 1:length(IB)
                IB_arti(1, i);
                IB(1, j);
                if IB_arti(1, i) == IB(1, j)
                ax_en_IB(1, k4) = IB_arti(1, i);
                k4 = 1 + k4;
                end
            end
        end
        ax_en_IB;
        
        %Si hay artificiales en la base
        if isempty(ax_en_IB) == false
            s = "El problema original no tiene solución factible"
            return 
        end
        
        ax_en_IN = [];
        k5 = 1;        
        %revisar si hay artificiales en la no base
        for i = 1:length(IB_arti)
            for j = 1:length(IN)
                IB_arti(1, i);
                IN(1, j);
                if IB_arti(1, i) == IN(1, j)
                ax_en_IN(1, k5) = IB_arti(1, i);
                k5 = 1 + k5;
                end
            end
        end
        ax_en_IN;
        
        %Si no hay artificiales en la base listo para fase 2
        if isequal(ax_en_IB, []) & length(ax_en_IN) ~= 0
                c = c_cop;
                A = A_cop;
            if procedimiento == "Si"
                c
                A
            end
            
            IB;
            N = [];
            XB = [];
            ind_XB = [];
            cN_prim = [];
            cB_prim = [];
            Zo = [];
            k6 = 1;
            x_in_IN = [];
            %Quita de IN las variables artificiales
            for i = 1:length(IN)
                [q] = find(IB_arti == IN(1, i));
                if isempty(q)
                    x_in_IN(1, k6) = IN(1, i);
                    k6 = 1 + k6;
                end
            end

            IN = x_in_IN;
            continue
        end
        
        %Verifica si en los costos hay al menos un 0
        count = 0;
        for i = 1:length(cN_)
            if cN_(1, i) == 0
                count = 1 + count;
            end
        end
        
        %Si hay al menos un cero 
        if count ~= 0
            s = "Conjunto de soluciones óptimas (óptimos alternos)"
            return 
        end
        s = "Solución"
        X_
        return
    else
        [min_cN, ind_min_cN] = min(men_cero); %Busca el mínimo entre los menores a 0
        i_m_cN = ind_men_cero(1, ind_min_cN); %Busca el índice del menor y este es el que entra a la Base
    end
    
    if procedimiento == "Si"
        min_cN          %Valor mínimo de los cN
        i_m_cN          %mínimo de los cN (Este es el que entra a la base)
    end
    
    %Vector Yaj
    Y = B_inv*A(:, i_m_cN); %ind_XB posee los índices de Y
    Y_invert = transpose(Y);
    
    Y_men_cero = [];
    ind_Y_men_cero = [];
    Y_may_cero = [];
    ind_Y_may_cero = [];
    j2 = 1;
    % k2 = 1;
    for i = 1:length(Y_invert)
        if Y_invert(1, i) <= 0
            Y_men_cero(1, j2) =  Y_invert(1, i);
            ind_Y_men_cero(1, j2) = IB(1, i);
            j2 = 1 + j2;
    %     else
    %         Y_may_cero(1, k2) = Y_invert(1, i)
    %         ind_Y_may_cero(1, k2) = IB(1, i)
    %         k2 = 1 + k2;
        end

    end
    Y_men_cero; %Y menores o iguales a 0
    ind_Y_men_cero; %Índice de los Y's menores o iguales a 0
    % Y_may_cero 
    % ind_Y_may_cero
    
    if procedimiento == "Si"
        Y
    end 
    
    if length(Y_men_cero) == length(IB)
        s = "El problema no tiene óptimo finito (no acotado)"
        IB;
        IN;
        X_;
        return 
    end

    % Haciendo uso de XB_tras y Y_invert haciendo XBi/Yik (prueba de la
    % razón mínima)
    j3 = 1;
    eps = [];
    ind_eps = [];
    for i = 1:length(Y_invert)
        if IB(1, i) == IB(1, i) & Y_invert(1, i) > 0
            eps(1, j3) = XB_tras(1, i)/Y_invert(1, i);
            ind_eps(1, j3) = IB(1, i);
            j3 = 1 + j3;
        end
    end
    

    
    eps; %Todos los posibles epsilon 
    ind_eps; %Índice de todos los posibles epsilon

    [min_eps, min_eps_id] = min(eps); %min_eps el menor epsilon *** min_eps_id el indice del indice 
    min_eps;

    ind_min_eps(1,1) = ind_eps(1, min_eps_id); %X ind_min_eps sale 
        
    % Cambio 
    [q] = find(IN == i_m_cN); %Encuentra el índice en el que está guardado el índice
    [p] = find(IB == ind_min_eps);
    IN(1, q) = ind_min_eps;
    IB(1, p) = i_m_cN;
    if procedimiento == "Si"
        eps
        min_eps             %El epsilon más pequeño
        ind_min_eps         %El índice del epsilon más pequeño (El que sale de la base)
        IN                  %Nuevos índices no básicos
        IB                  %Nuevos índices básicos
    end
end


end 