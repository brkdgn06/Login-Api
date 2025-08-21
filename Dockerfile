# SDK imajı
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build

# Çalışma dizini
WORKDIR /src

# Proje dosyasını ayrı kopyala
COPY SwordLoginApi/SwordLoginApi.csproj ./SwordLoginApi/

# Restore işlemi
RUN dotnet restore ./SwordLoginApi/SwordLoginApi.csproj

# Tüm dosyaları kopyala
COPY . .

# Yayınla
WORKDIR /src/LoginApi
RUN dotnet publish -c Release -o /app/publish

# Runtime imajı
FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS runtime
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "SwordLoginApi.dll"]