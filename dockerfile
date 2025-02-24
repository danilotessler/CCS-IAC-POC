#BUILD
#------
    FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

    WORKDIR /src
    COPY . .
    RUN dotnet restore 
    WORKDIR "/src/."
    RUN dotnet build -o /app/build
    RUN dotnet publish -o /app/publish /p:UseAppHost=false
    
    #RUN
    #------
    FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
    
    WORKDIR /app
    
    COPY --from=build /app/publish .
    
    EXPOSE 80
    ENV DOTNET_URLS=http://+:80
    
    ENTRYPOINT ["dotnet", "CCS.dll"]