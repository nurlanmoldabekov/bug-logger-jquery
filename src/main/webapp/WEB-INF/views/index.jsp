<!DOCTYPE html>
<html>
<head>
    <title>Bug Tracker</title>
    <script
            src="https://code.jquery.com/jquery-3.4.0.js"
            integrity="sha256-DYZMCC8HTC+QDr5QNaIcfR7VSPtcISykd+6eSmBW5qo="
            crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">Bug Tracker</a>
    </div>
</nav>

<div class="container mt-4">
    <div class="row">
        <div class="col-md-6">
            <h2 class="mb-3">Submit a Bug</h2>
            <form id="bugForm" class="card p-3 shadow-sm">
                <div class="mb-3">
                    <label for="bugTitle" class="form-label">Title</label>
                    <input type="text" maxlength="50" class="form-control" id="bugTitle" name="bugTitle" placeholder="Enter bug title">
                    <div id="titleError" class="text-danger"></div>
                </div>
                <div class="mb-3">
                    <label for="description" class="form-label">Description</label>
                    <textarea class="form-control" maxlength="255" id="description" name="description" placeholder="Enter description" rows="3"></textarea>
                    <div id="descriptionError" class="text-danger"></div>
                </div>
                <div class="mb-3">
                    <label for="severity" class="form-label">Severity</label>
                    <select class="form-select" id="severity" name="severity">
                        <option value="LOW">Low</option>
                        <option value="MEDIUM">Medium</option>
                        <option value="HIGH">High</option>
                        <option value="CRITICAL">Critical</option>
                    </select>
                </div>
                <div class="mb-3">
                    <label for="status" class="form-label">Status</label>
                    <select class="form-select" id="status" name="status">
                        <option value="OPEN">Open</option>
                        <option value="IN_PROGRESS">In Progress</option>
                        <option value="RESOLVED">Resolved</option>
                        <option value="CLOSED">Closed</option>
                    </select>
                </div>
                <button type="submit" class="btn btn-primary">Submit</button>
            </form>
        </div>

        <div class="col-md-6">
            <h2 class="mb-3">Filter Bugs</h2>
            <form id="filterForm" class="card p-3 shadow-sm">
                <div class="mb-3">
                    <label for="queryFilter" class="form-label">Search Query</label>
                    <input type="text" id="queryFilter" class="form-control" placeholder="Enter keyword">
                </div>
                <div class="mb-3">
                    <label for="severityFilter" class="form-label">Severity</label>
                    <select id="severityFilter" class="form-select">
                        <option value="">All Severities</option>
                        <option value="LOW">Low</option>
                        <option value="MEDIUM">Medium</option>
                        <option value="HIGH">High</option>
                        <option value="CRITICAL">Critical</option>
                    </select>
                </div>
                <div class="mb-3">
                    <label for="statusFilter" class="form-label">Status</label>
                    <select id="statusFilter" class="form-select">
                        <option value="">All Statuses</option>
                        <option value="OPEN">Open</option>
                        <option value="IN_PROGRESS">In Progress</option>
                        <option value="RESOLVED">Resolved</option>
                        <option value="CLOSED">Closed</option>
                    </select>
                </div>
                <div class="d-flex">
                    <button type="button" class="btn btn-secondary me-2" onclick="loadBugs()">Filter</button>
                    <button type="button" class="btn btn-danger" onclick="resetFilters()">Reset Filters</button>
                </div>
            </form>
        </div>
    </div>

    <div class="row mt-4">
        <div class="col-12">
            <h2 class="mb-3">Bug List</h2>
            <table class="table table-striped table-bordered shadow-sm" id="bugTable">
                <thead class="table-dark">
                <tr>
                    <th>ID</th>
                    <th>Title</th>
                    <th>Description</th>
                    <th>Severity</th>
                    <th>Status</th>
                </tr>
                </thead>
                <tbody></tbody>
            </table>
            <div class="d-flex justify-content-center mt-3">
                <nav>
                    <ul id="pagination" class="pagination">
                        <li class="page-item">
                            <button class="page-link secondary" onclick="loadBugs(currentPage - 1)" id="prevPage">Previous</button>
                        </li>
                        <li class="page-item">
                            <button class="page-link secondary" onclick="loadBugs(currentPage + 1)" id="nextPage">Next</button>
                        </li>
                    </ul>
                </nav>
            </div>
        </div>
    </div>
</div>

<!-- Modal -->
<div class="modal fade" id="bugDetailModal" tabindex="-1" aria-labelledby="bugDetailModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content border-0 shadow-lg">
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title" id="bugDetailModalLabel">
                    <i class="bi bi-bug-fill me-2"></i>Bug Details
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body px-4 py-3">
                <div class="mb-3">
                    <label class="form-label"><strong>ID:</strong></label>
                    <div id="modalBugId" class="form-control bg-light"></div>
                </div>
                <div class="mb-3">
                    <label class="form-label"><strong>Title:</strong></label>
                    <div id="modalBugTitle" class="form-control bg-light"></div>
                </div>
                <div class="mb-3">
                    <label class="form-label"><strong>Description:</strong></label>
                    <textarea class="form-control bg-light" rows="4" id="modalBugDescription" disabled></textarea>
                </div>
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label"><strong>Severity:</strong></label>
                        <div id="modalBugSeverity" class="form-control bg-light"></div>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label"><strong>Status:</strong></label>
                        <div id="modalBugStatus" class="form-control bg-light"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>

    String.prototype.compose = (function () {
        var re = /\{{(.+?)\}}/g;
        return function (o) {
            return this.replace(re, function (_, k) {
                return typeof o[k] != 'undefined' ? o[k] : '';
            });
        }
    }());

    $(function () {
        loadBugs();

        $("#bugForm").submit(function (e) {
            e.preventDefault();

            $("#titleError").text("");
            $("#descriptionError").text("");

            // Validation
            let title = $("#bugTitle").val();
            let description = $("#description").val();
            let hasErrors = false;

            if (title.length < 10) {
                $("#titleError").text("Title must be at least 10 characters long.");
                hasErrors = true;
            }
            if (description.length < 20) {
                $("#descriptionError").text("Description must be at least 20 characters long.");
                hasErrors = true;
            }

            if (hasErrors) {
                return;
            }

            // Submit the form if validation passes
            let data = {};
            $(this).serializeArray().forEach(function (x) {
                data[x.name] = x.value;
            });
            $.ajax({
                url: "/bugs",
                method: "POST",
                contentType: "application/json",
                data: JSON.stringify(data),
                success: function () {
                    loadBugs();
                    $("#bugForm")[0].reset();
                }
            });
        });
    });

    let currentPage = 0;

    function loadBugs(page = 0) {
        currentPage = page;
        let query = $("#queryFilter").val();
        let severity = $("#severityFilter").val();
        let status = $("#statusFilter").val();
        let url = "/bugs?page=" + page + "&pageSize=3";


        let queryParams = [];
        if (query) {
            queryParams.push("query=" + encodeURIComponent(query));
        }
        if (severity) {
            queryParams.push("severity=" + encodeURIComponent(severity));
        }
        if (status) {
            queryParams.push("status=" + encodeURIComponent(status));
        }
        if (queryParams.length > 0) {
            url += "&" + queryParams.join("&");
        }

        $.get(url, function (data) {
            let rows = "";
            var row = '<tr>' +
                '<td>{{id}}</td>' +
                '<td><a href="#" class="bug-title" data-id="{{id}}" data-title="{{fullTitle}}" data-full-description="{{fullDescription}}" data-severity="{{severity}}" data-status="{{status}}">{{bugTitle}}</a></td>' +
                '<td>{{shortDescription}}</td>' +
                '<td>{{severity}}</td>' +
                '<td>{{status}}</td>' +
                '</tr>';

            data.content.forEach(bugEntity => {
                let fullDescription = bugEntity.description;
                let shortDescription = fullDescription.length > 10
                    ? fullDescription.substring(0, 10) + "..."
                    : fullDescription;

                let fullTitle = bugEntity.bugTitle;
                let shortTitle = fullTitle.length > 10
                    ? fullTitle.substring(0, 10) + "..."
                    : fullTitle;

                rows += row.compose({
                    'id': bugEntity.id,
                    'bugTitle': shortTitle,
                    'fullTitle': fullTitle,
                    'shortDescription': shortDescription,
                    'fullDescription': fullDescription,
                    'severity': bugEntity.severity,
                    'status': bugEntity.status
                });
            });

            $("#bugTable tbody").empty().append(rows);


            let paginationLinks = "";
            for (let i = 0; i < data.totalPages; i++) {
                paginationLinks += "<li class=\"page-item" + (i === data.number ? ' active' : '') + "\">" +
                    "<button class=\"page-link\" onclick=\"loadBugs(" + i + ")\">" + (i + 1) + "</button>" +
                    "</li>";
            }

            $("#pagination").empty();

            $("#pagination").append("<li class=\"page-item\"> <button class=\"page-link secondary\" onclick=\"loadBugs(currentPage - 1)\" id=\"prevPage\">Previous</button> </li>");
            $("#pagination").append(paginationLinks);
            $("#pagination").append("<button class=\"page-link secondary\" onclick=\"loadBugs(currentPage + 1)\" id=\"nextPage\">Next</button>");

            $("#prevPage").prop("disabled", data.number === 0);
            $("#nextPage").prop("disabled", data.number + 1 === data.totalPages);
        }).fail(function () {
            alert("Failed to load bugs. Please try again.");
        });
    }
    function resetFilters() {
        $("#queryFilter").val("");
        $("#severityFilter").val("");
        $("#statusFilter").val("");
        loadBugs();
    }

    $("#bugTable").on("click", ".bug-title", function (e) {
        e.preventDefault();
        $("#modalBugId").text($(this).data("id"));
        $("#modalBugTitle").text($(this).data("title"));
        $("#modalBugDescription").text($(this).data("full-description"));
        $("#modalBugSeverity").text($(this).data("severity"));
        $("#modalBugStatus").text($(this).data("status"));

        let modal = new bootstrap.Modal(document.getElementById('bugDetailModal'));
        modal.show();
    });
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
</body>
</html>