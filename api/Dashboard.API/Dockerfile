# ---- Build image ----
FROM mcr.microsoft.com/dotnet/core/sdk:3.1-alpine as build

WORKDIR /src

ENV ASPNETCORE_ENVIRONMENT=Production
ENV DOTNET_CLI_TELEMETRY_OPTOUT=true
ENV WEATHER_KEY=NONE
ENV MOVIESDB_KEY=NONE
ENV NASA_KEY=NONE
ENV OMDP_KEY=NONE


# Restore dependencies and tools for current project
COPY *.csproj ./Dashboard.API/
RUN dotnet restore ./Dashboard.API/*.csproj

# Sources
COPY . ./Dashboard.API/

# Build
RUN dotnet publish ./Dashboard.API/*.csproj -c Release -o /app

# ---- Runtime image ----
FROM mcr.microsoft.com/dotnet/core/aspnet:3.1-alpine

WORKDIR /app

ENV ASPNETCORE_ENVIRONMENT=Production
ENV DOTNET_CLI_TELEMETRY_OPTOUT=true

# SOURCES
COPY --from=build /app .

EXPOSE 8080
CMD ["dotnet", "Dashboard.API.dll"]