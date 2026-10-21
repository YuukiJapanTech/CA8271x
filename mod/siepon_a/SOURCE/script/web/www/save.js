(function () {
  "use strict";

  function encode(value) {
    return encodeURIComponent(value).replace(/%20/g, "+");
  }

  function encodeForm(form) {
    var fields = form.elements;
    var values = [];
    var i;

    for (i = 0; i < fields.length; i += 1) {
      var field = fields[i];
      var type = (field.type || "").toLowerCase();

      if (!field.name || field.disabled || type === "submit" ||
          type === "button" || type === "reset" || type === "file") {
        continue;
      }

      if ((type === "checkbox" || type === "radio") && !field.checked) {
        continue;
      }

      values.push(encode(field.name) + "=" + encode(field.value));
    }

    return values.join("&");
  }

  function initializeSaveForm() {
    var form = document.querySelector('form[method="POST"]');

    if (!form || !window.fetch) {
      return;
    }

    var submit = form.querySelector('input[type="submit"]');
    var status = document.createElement("span");
    var saving = false;

    status.setAttribute("role", "status");
    status.setAttribute("aria-live", "polite");
    status.style.marginLeft = "0.75em";

    if (submit && submit.parentNode) {
      submit.parentNode.insertBefore(status, submit.nextSibling);
    } else {
      form.appendChild(status);
    }

    function setFinished(message, color) {
      saving = false;
      if (submit) {
        submit.disabled = false;
      }
      status.style.color = color;
      status.textContent = message;
    }

    function warnBeforeUnload(event) {
      if (!saving) {
        return undefined;
      }

      event.preventDefault();
      event.returnValue = "";
      return "";
    }

    window.addEventListener("beforeunload", warnBeforeUnload);

    form.addEventListener("submit", function (event) {
      event.preventDefault();

      if (saving) {
        return;
      }

      saving = true;
      if (submit) {
        submit.disabled = true;
      }
      status.style.color = "";
      status.textContent = "Saving... Please wait.";

      fetch(form.action, {
        method: "POST",
        headers: {
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: encodeForm(form),
        cache: "no-store",
        credentials: "same-origin"
      })
        .then(function (response) {
          return response.text().then(function (message) {
            return {
              ok: response.ok,
              message: message.trim()
            };
          });
        })
        .then(function (result) {
          if (!result.ok || result.message !== "Saved") {
            throw new Error(result.message || "Save failed.");
          }
          setFinished("Saved", "green");
        })
        .catch(function (error) {
          setFinished(error.message || "Save failed.", "darkred");
        });
    });
  }

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", initializeSaveForm);
  } else {
    initializeSaveForm();
  }
}());
