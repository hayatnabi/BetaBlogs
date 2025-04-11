# README

This is a demo RoR articles or blogs website for learning purposes. Hop in and enjoy the code!


Following is the method to delete using turbo enabled web app:

 <%= link_to 'Delete', article_path(article),
                        data: { turbo_method: :delete, turbo_confirm: 'Are you sure you want to delete this article?' },
                        class: "btn btn-sm btn-outline-danger" %>