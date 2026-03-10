/**
 * Handlebars helpers for JSON Resume theme
 */

function registerHelpers(Handlebars) {
  // Format ISO date to "Mon Year" or just "Year"
  Handlebars.registerHelper('formatDate', function(dateStr) {
    if (!dateStr) return 'Present';
    const [year, month] = dateStr.split('-');
    if (!month) return year;
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return `${months[parseInt(month, 10) - 1]} ${year}`;
  });

  // Check if array has items
  Handlebars.registerHelper('hasItems', function(arr, options) {
    if (arr && arr.length > 0) {
      return options.fn(this);
    }
    return options.inverse(this);
  });

  // Join array with separator
  Handlebars.registerHelper('join', function(arr, separator) {
    if (!arr || !Array.isArray(arr)) return '';
    return arr.join(separator || ', ');
  });

  // Strip protocol from URL
  Handlebars.registerHelper('stripProtocol', function(url) {
    if (!url) return '';
    return url.replace(/^https?:\/\//, '');
  });

  // Build location string from location object
  Handlebars.registerHelper('locationString', function(location) {
    if (!location) return '';
    return [location.city, location.region, location.countryCode].filter(Boolean).join(', ');
  });

  // Check if value exists
  Handlebars.registerHelper('if_exists', function(value, options) {
    if (value) {
      return options.fn(this);
    }
    return options.inverse(this);
  });
}

module.exports = { registerHelpers };
