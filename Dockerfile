# Step 1: Use the official ASP.NET Core runtime as the base for execution
FROM mcr.microsoft.com/dotnet/aspnet:10.0 AS base
WORKDIR /app

# Step 2: Use the full .NET SDK image to build and compile the C# code
FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
WORKDIR /src

# Copy the project file and restore any NuGet packages
COPY ["MyApp.csproj", "."]
RUN dotnet restore "./MyApp.csproj"

# Copy the rest of your code (including Program.cs, wwwroot, Pages) and build it
COPY . .
RUN dotnet build "MyApp.csproj" -c Release -o /app/build

# Step 3: Publish the compiled website files into a clean package
FROM build AS publish
RUN dotnet publish "MyApp.csproj" -c Release -o /app/publish

# Step 4: Build the final execution image
FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "MyApp.dll"]