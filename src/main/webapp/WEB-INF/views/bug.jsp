<!DOCTYPE html>
<html>
<head>
    <title>Bug Tracker</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
            crossorigin="anonymous"></script>
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
                    <input type="text" class="form-control" id="bugTitle" name="bugTitle" placeholder="Enter bug title">
                </div>
                <div class="mb-3">
                    <label for="description" class="form-label">Description</label>
                    <input type="text" class="form-control" id="description" name="description" placeholder="Enter description">
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
        </div>
    </div>
</div>

<script>
    //Compose template string
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

    function loadBugs() {
        let query = $("#queryFilter").val();
        let severity = $("#severityFilter").val();
        let status = $("#statusFilter").val();
        let url = "/bugs";

        // Build query string
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
            url += "?" + queryParams.join("&");
        }

        $.get(url, function (data) {
            let rows = "";
            var row = '<tr>' +
                '<td>{{id}}</td>' +
                '<td>{{bugTitle}}</td>' +
                '<td>{{description}}</td>' +
                '<td>{{severity}}</td>' +
                '<td>{{status}}</td>' +
                '</tr>';

            data.forEach(bug => {
                rows += row.compose({
                    'id': bug.id,
                    'bugTitle': bug.bugTitle,
                    'description': bug.description,
                    'severity': bug.severity,
                    'status': bug.status
                });
            });

            $("#bugTable tbody").empty().append(rows);
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
</script>
</body>
</html>