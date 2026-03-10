/**
 * JSON Resume Theme Renderer using Handlebars
 */

const fs = require('fs');
const path = require('path');

function render(resume, options = {}) {
  const themeDir = options.themeDir || __dirname;
  const handlebarsPath = options.handlebarsPath || path.join(themeDir, 'handlebars.min.js');

  // Load Handlebars
  const Handlebars = require(handlebarsPath);

  // Register helpers
  const { registerHelpers } = require(path.join(themeDir, 'helpers.js'));
  registerHelpers(Handlebars);

  // Load CSS
  const css = fs.readFileSync(path.join(themeDir, 'style.css'), 'utf-8');

  // Load and register partials
  const partialsDir = path.join(themeDir, 'templates', 'partials');
  const partialFiles = fs.readdirSync(partialsDir);

  partialFiles.forEach(file => {
    if (file.endsWith('.hbs')) {
      const name = path.basename(file, '.hbs');
      const content = fs.readFileSync(path.join(partialsDir, file), 'utf-8');
      Handlebars.registerPartial(name, content);
    }
  });

  // Load and compile main template
  const layoutPath = path.join(themeDir, 'templates', 'layout.hbs');
  const layoutSource = fs.readFileSync(layoutPath, 'utf-8');
  const template = Handlebars.compile(layoutSource);

  // Render with data
  const data = {
    ...resume,
    css: css
  };

  return template(data);
}

module.exports = { render };
