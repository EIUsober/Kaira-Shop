function debounce(func, delay) {
            let debounceTimer;
            return function() {
                const context = this;
                const args = arguments;
                clearTimeout(debounceTimer);
                debounceTimer = setTimeout(() => func.apply(context, args), delay);
            };
        }

        // AJAX search function
        function search(query) {
            if (query.length === 0) {
                document.getElementById("results").innerHTML = "";
                return;
            }

            const xhr = new XMLHttpRequest();
            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    document.getElementById("results").innerHTML = xhr.responseText;
                }
            };
            xhr.open("GET", "AdminControl?mode=searchProduct&query=" + query, true);
            xhr.send();
        }

        // Apply debounce to search function
        const debouncedSearch = debounce(search, 100);