<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Mi Negocio</title>
  <style>
    :root {
      --color-fondo: #f5f5f5;
      --color-primario: #333;
      --color-secundario: #007bff;
      --fuente-titulo: 'Cooper Black', sans-serif;
      --fuente-texto: Arial, sans-serif;
    }

    body {
      margin: 0;
      font-family: var(--fuente-texto);
      background-color: var(--color-fondo);
    }

    header {
      background: url('https://images.unsplash.com/photo-1586281380383-d7aabf6b9db6') no-repeat center;
      background-size: cover;
      padding: 60px 20px;
      text-align: center;
      color: white;
    }

    header h1 {
      font-family: var(--fuente-titulo);
      font-size: 3em;
      margin: 0;
    }

    nav {
      background-color: white;
      padding: 10px 20px;
      display: flex;
      flex-wrap: wrap;
      justify-content: center;
      gap: 10px;
      box-shadow: 0 2px 5px rgba(0,0,0,0.1);
      position: sticky;
      top: 0;
      z-index: 999;
    }

    nav button {
      padding: 10px 15px;
      border: none;
      background-color: var(--color-secundario);
      color: white;
      border-radius: 5px;
      cursor: pointer;
    }

    #idiomaSelect {
      padding: 8px;
      border-radius: 5px;
      border: 1px solid #ccc;
    }

    main {
      padding: 30px 20px;
      display: flex;
      flex-wrap: wrap;
      justify-content: center;
      gap: 20px;
    }

    .producto {
      background: white;
      border-radius: 10px;
      box-shadow: 0 0 8px rgba(0,0,0,0.1);
      width: 220px;
      padding: 15px;
      text-align: center;
      transition: transform 0.2s ease;
    }

    .producto:hover {
      transform: scale(1.03);
    }

    .producto img {
      width: 100%;
      height: 140px;
      object-fit: cover;
      border-radius: 5px;
    }

    footer {
      background: #ddd;
      padding: 20px;
      text-align: center;
      font-size: 0.9em;
      margin-top: 40px;
    }

    @media (max-width: 600px) {
      header h1 {
        font-size: 2em;
      }

      .producto {
        width: 90%;
      }
    }
  </style>
</head>
<body>

  <nav>
    <button onclick="alert('Ir a lo más vendido')">Lo más vendido</button>
    <button onclick="alert('Ir a ofertas')">Ofertas</button>
    <button onclick="alert('Ir a lo nuevo')">Lo nuevo</button>
    <button onclick="alert('Ir a productos personalizados')">Personalizados</button>
    <button onclick="alert('Ir a contáctanos')">Contáctanos</button>
    <button onclick="alert('Ir a sobre nosotros')">Sobre nosotros</button>
    <button onclick="alert('Ir al carrito')">🛒</button>
    <select id="idiomaSelect" onchange="cambiarIdioma(this.value)">
      <option value="es">Español</option>
      <option value="en">English</option>
    </select>
  </nav>

  <header>
    <h1 id="titulo">Mi Negocio</h1>
  </header>

  <main id="galeria">
    <!-- Productos generados por JS -->
  </main>

  <footer>
    <p id="contacto">Contacto: correo@ejemplo.com | Tel: 123 456 7890</p>
  </footer>

  <script>
    const productos = Array.from({ length: 20 }, (_, i) => ({
      nombre: `Producto ${i + 1}`,
      descripcion: `Descripción breve del producto ${i + 1}`,
      imagen: "https://via.placeholder.com/220x140.png?text=Producto+" + (i + 1)
    }));

    function renderizarProductos() {
      const contenedor = document.getElementById("galeria");
      contenedor.innerHTML = "";

      productos.forEach(p => {
        const div = document.createElement("div");
        div.className = "producto";
        div.innerHTML = `
          <img src="${p.imagen}" alt="${p.nombre}">
          <h3>${p.nombre}</h3>
          <p>${p.descripcion}</p>
          <button onclick="alert('Ver más')">Ver más</button>
        `;
        contenedor.appendChild(div);
      });
    }

    function cambiarIdioma(idioma) {
      if (idioma === "en") {
        document.getElementById("titulo").textContent = "My Business";
        document.querySelectorAll("nav button")[0].textContent = "Best Sellers";
        document.querySelectorAll("nav button")[1].textContent = "Offers";
        document.querySelectorAll("nav button")[2].textContent = "New";
        document.querySelectorAll("nav button")[3].textContent = "Custom";
        document.querySelectorAll("nav button")[4].textContent = "Contact Us";
        document.querySelectorAll("nav button")[5].textContent = "About Us";
        document.getElementById("contacto").textContent = "Contact: email@example.com | Phone: 123 456 7890";
      } else {
        document.getElementById("titulo").textContent = "Mi Negocio";
        document.querySelectorAll("nav button")[0].textContent = "Lo más vendido";
        document.querySelectorAll("nav button")[1].textContent = "Ofertas";
        document.querySelectorAll("nav button")[2].textContent = "Lo nuevo";
        document.querySelectorAll("nav button")[3].textContent = "Personalizados";
        document.querySelectorAll("nav button")[4].textContent = "Contáctanos";
        document.querySelectorAll("nav button")[5].textContent = "Sobre nosotros";
        document.getElementById("contacto").textContent = "Contacto: correo@ejemplo.com | Tel: 123 456 7890";
      }
    }

    window.onload = () => {
      renderizarProductos();
    };
  </script>
</body>
</html>
