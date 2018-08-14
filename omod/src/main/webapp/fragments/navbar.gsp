<link rel="import" href="../bower_components/paper-icon-button/paper-icon-button.html">
<link rel="import" href="../bower_components/iron-icons/iron-icons.html">
<link rel="import" href="../bower_components/paper-toolbar/paper-toolbar.html">
<link rel="import" href="../bower_components/iron-icons/social-icons.html">
<link rel="import" href="../bower_components/iron-icons/image-icons.html">
<link rel="import" href="../bower_components/iron-icons/av-icons.html">
<link rel="import" href="../bower_components/paper-listbox/paper-listbox.html">
<link rel="import" href="../bower_components/paper-button/paper-button.html">
<link rel="import" href="../bower_components/paper-item/paper-item.html">
<link rel="import" href="../bower_components/paper-menu-button/paper-menu-button.html">
<link rel="import" href="../bower_components/paper-button/paper-button.html">
<link rel="import" href="../bower_components/iron-demo-helpers/demo-pages-shared-styles.html">
<link rel="import" href="../bower_components/vaadin-upload/vaadin-upload.html">
<link rel="import" href="collapse-button.html">
<link rel="import" href="stlm-diff.html">
<link rel="import" href="simple-dialog.html">

<script src="../bower_components/web-animations-js/web-animations-next-lite.min.js"></script>
<dom-module id="stlm-navbar">
    <template>
        <style>
        :host {
            display: block;
        }

        paper-item {
            cursor: pointer;
            width: 250px;
        }

        paper-listbox {
            height: 200px;
            width: 300px;
        }

        paper-button {
            min-width: 30px;
            height: 20px;
        }

        paper-button.backbutton {
            background-color: var(--paper-amber-500);
        }

        paper-button.compare {
            background-color: var(--paper-light-blue-500);
        }

        paper-button.green {
            background-color: var(--paper-green-500);
        }

        paper-button.red {
            background-color: var(--paper-red-500);
            color: white;
        }

        paper-toolbar {
            --paper-toolbar-height: 30px;
        }
        </style>
        <paper-toolbar>
            <paper-menu-button slot="top" style="width:20%">
                <paper-button slot="dropdown-trigger">[[selectedCourseName]]
                    <iron-icon icon="chrome-reader-mode"></iron-icon>
                </paper-button>
                <paper-listbox slot="dropdown-content" selected="{{selectedCourseName}}" attr-for-selected="coursename">
                    <template is="dom-repeat" items="[[suggestions]]" as="suggestion">
                        <paper-item coursename="[[suggestion.name]]">[[suggestion.name]]</paper-item>
                    </template>
                </paper-listbox>
            </paper-menu-button>
            <paper-button style="width:20%" slot="top">Statistical Analysis&nbsp;<iron-icon
                    icon="social:poll"></iron-icon>
            </paper-button>
            <paper-button style="width:20%" slot="top">SQL&nbsp;<iron-icon icon="sort"></iron-icon>
            </paper-button>
            <paper-menu-button slot="top" style="width:20%">
                <paper-button slot="dropdown-trigger">Submission&nbsp;<iron-icon
                        icon="assignment-turned-in"></iron-icon>
                </paper-button>
                <paper-listbox slot="dropdown-content">
                    <paper-item>Spreadsheet</paper-item>
                    <paper-item>Data Flow Diagram</paper-item>
                    <paper-item on-tap="toggleDialog">Upload Files</paper-item>
                </paper-listbox>
            </paper-menu-button>
            <paper-menu-button slot="top" style="width:20%">
                <paper-button slot="dropdown-trigger">Assignment&nbsp;<iron-icon icon="assignment"></iron-icon>
                </paper-button>
                <paper-listbox id="assignmentList" slot="dropdown-content">
                    <collapse-button>
                        <paper-item slot="sublist-collapse-item" on-tap="closeOtherOpened">Assignment 1<iron-icon icon="arrow-drop-down"></iron-icon></paper-item>
                        <paper-item>Question1
                            <paper-button raised class="green startbutton" id="ass1-q1" on-tap="startRecording">
                                <iron-icon icon="av:play-circle-outline"></iron-icon>
                            </paper-button>
                            <paper-button disabled raised class="backbutton" on-tap="revertRecording">
                                <iron-icon icon="undo"></iron-icon>
                            </paper-button>
                            <paper-button disabled raised id="comparebutton" class="compare" onclick="document.getElementsByTagName('stlm-diff')[0].prettyTest(this.previousElementSibling.previousElementSibling.id)">
                                <iron-icon icon="image:compare"></iron-icon>
                            </paper-button>
                        </paper-item>
                        <paper-item>Question2
                            <paper-button raised class="green startbutton" id="ass1-q2" on-tap="startRecording">
                                <iron-icon icon="av:play-circle-outline"></iron-icon>
                            </paper-button>
                            <paper-button disabled raised class="backbutton" on-tap="revertRecording">
                                <iron-icon icon="undo"></iron-icon>
                            </paper-button>
                            <paper-button disabled raised id="comparebutton" class="compare" onclick="document.getElementsByTagName('stlm-diff')[0].prettyTest(this.previousElementSibling.previousElementSibling.id)">
                                <iron-icon icon="image:compare"></iron-icon>
                            </paper-button>
                        </paper-item>
                    </collapse-button>
                    <collapse-button>
                        <paper-item slot="sublist-collapse-item" on-tap="closeOtherOpened">Assignment 2<iron-icon icon="arrow-drop-down"></iron-icon></paper-item>
                        <paper-item>Question1
                            <paper-button raised class="green startbutton" id="ass2-q1" on-tap="startRecording">
                                <iron-icon icon="av:play-circle-outline"></iron-icon>
                            </paper-button>
                            <paper-button disabled raised class="backbutton" on-tap="revertRecording">
                                <iron-icon icon="undo"></iron-icon>
                            </paper-button>
                            <paper-button disabled raised id="comparebutton" class="compare" onclick="document.getElementsByTagName('stlm-diff')[0].prettyTest(this.previousElementSibling.previousElementSibling.id)">
                                <iron-icon icon="image:compare"></iron-icon>
                            </paper-button>
                        </paper-item>
                        <paper-item>Question2
                            <paper-button raised class="green startbutton" id="ass2-q2" on-tap="startRecording">
                                <iron-icon icon="av:play-circle-outline"></iron-icon>
                            </paper-button>
                            <paper-button disabled raised class="backbutton" on-tap="revertRecording">
                                <iron-icon icon="undo"></iron-icon>
                            </paper-button>
                            <paper-button disabled raised id="comparebutton" class="compare" onclick="document.getElementsByTagName('stlm-diff')[0].prettyTest(this.previousElementSibling.previousElementSibling.id)">
                                <iron-icon icon="image:compare"></iron-icon>
                            </paper-button>
                        </paper-item>
                    </collapse-button>
                </paper-listbox>
            </paper-menu-button>
        </paper-toolbar>
        <simple-dialog id="dialog">
            <h2>Please upload your files here</h2>
            <vaadin-upload accept=".pdf,.doc,.docx,.xml" target="serverUrl" method="POST" timeout="300000"
                           headers="{'X-Custom-Header': 'value'}"
                           form-data-name="my-attachment">
                <iron-icon slot="drop-label-icon" icon="description"></iron-icon>
                <span slot="drop-label">Drop your files here</span>
            </vaadin-upload>
            <paper-button dialog-dismiss>Cancel</paper-button>
            <paper-button dialog-confirm autofocus>submit</paper-button>
            <script src="https://cdn.vaadin.com/vaadin-elements/master/mock-http-request/lib/mock.js"></script>
            <script>
                function mockXhrGenerator(file) {
                    var xhr = new MockHttpRequest();
                    xhr.upload = {};
                    xhr.onsend = function () {
                        var total = file && file.size || 1024, done = 0;

                        function start() {
                            setTimeout(progress, 1000);
                        }

                        function progress() {
                            xhr.upload.onprogress({total: total, loaded: done});
                            if (done < total) {
                                setTimeout(progress, 200);
                                done = Math.min(total, done + 254000);
                            } else if (!file.abort) {
                                setTimeout(finish, 1000);
                            }
                        }

                        function finish() {
                            xhr.receive(200, '{"message":"OK"}');
                        }

                        start();
                    };
                    return xhr;
                }

                window.addEventListener('WebComponentsReady', function () {
                    // Monkey-patch vaadin-upload prototype to use MockHttpRequest
                    Object.getPrototypeOf(document.createElement('vaadin-upload'))._createXhr = mockXhrGenerator;
                });

            </script>
        </simple-dialog>
    </template>
    <script>
        class StlmNavbar extends Polymer.Element {
            static get is() {
                return 'stlm-navbar';
            }

            toggleDialog() {
                this.$.dialog.open();
            }

            startRecording(e) {
                // when user clicks on icon
                if (null === e.target.nextElementSibling) {
                    if (localStorage.getItem(e.target.parentNode.id) == 'started') {
                        e.target.parentNode.classList.remove('red');
                        e.target.parentNode.classList.add('green');
                        localStorage.setItem(e.target.parentNode.id, 'stopped');
                        e.target.parentNode.nextElementSibling.removeAttribute('disabled');
                        e.target.parentNode.nextElementSibling.nextElementSibling.removeAttribute('disabled');
                        e.target.parentNode.setAttribute('disabled', 'true');
                        e.target.parentNode.innerHTML = '<iron-icon icon="av:play-circle-outline"></iron-icon>';
                    } else {
                        e.target.parentNode.classList.remove('green');
                        e.target.parentNode.classList.add('red');
                        localStorage.setItem(e.target.parentNode.id, 'started');
                        e.target.parentNode.innerHTML = '<iron-icon icon="av:stop"></iron-icon>';
                    }
                } else { // when user clicks on the button
                    if (localStorage.getItem(e.target.id) == 'started') {
                        e.target.classList.remove('red');
                        e.target.classList.add('green');
                        localStorage.setItem(e.target.id, 'stopped');
                        e.target.nextElementSibling.removeAttribute('disabled');
                        e.target.nextElementSibling.nextElementSibling.removeAttribute('disabled');
                        e.target.setAttribute('disabled', 'true');
                        e.target.innerHTML = '<iron-icon icon="av:play-circle-outline"></iron-icon>';
                    } else {
                        e.target.classList.remove('green');
                        e.target.classList.add('red');
                        localStorage.setItem(e.target.id, 'started');
                        e.target.innerHTML = '<iron-icon icon="av:stop"></iron-icon>';
                    }
                }
            }

            revertRecording(e) {
                if (null === e.target.nextElementSibling) {
                    e.target.parentNode.previousElementSibling.removeAttribute('disabled');
                    localStorage.removeItem(e.target.parentNode.previousElementSibling.id);
                    e.target.parentNode.setAttribute('disabled', 'true');
                    e.target.parentNode.nextElementSibling.setAttribute('disabled', 'true');
                } else {
                    e.target.previousElementSibling.removeAttribute('disabled');
                    localStorage.removeItem(e.target.previousElementSibling.id);
                    e.target.setAttribute('disabled', 'true');
                    e.target.nextElementSibling.setAttribute('disabled', 'true');
                }
            }

            constructor() {
                super();
                this.suggestions = [{"id": "1", "name": "HIM M200"}, {"id": "2", "name": "HIM M220"}];
            }

            ready() {
                super.ready();
                for (var a in localStorage) {
                    if (a.includes('ass')) {
                        if (localStorage.getItem(a) == 'started') {
                            this.shadowRoot.getElementById(a).classList.remove('green');
                            this.shadowRoot.getElementById(a).classList.add('red');
                            this.shadowRoot.getElementById(a).innerHTML = '<iron-icon icon="av:stop"></iron-icon>';
                        } else if (localStorage.getItem(a) == 'stopped') {
                            this.shadowRoot.getElementById(a).setAttribute('disabled', 'true');
                            this.shadowRoot.getElementById(a).nextElementSibling.removeAttribute('disabled');
                            this.shadowRoot.getElementById(a).nextElementSibling.nextElementSibling.removeAttribute('disabled');
                            this.shadowRoot.getElementById(a).classList.remove('red');
                            this.shadowRoot.getElementById(a).classList.add('green');
                            this.shadowRoot.getElementById(a).innerHTML = '<iron-icon icon="av:play-circle-outline"></iron-icon>';
                        }
                    }
                }
            }

            closeOtherOpened(e) {
                for(let a of this.$.assignmentList.getElementsByTagName('collapse-button')) {
                    if(a != e.target) {
                        a.removeAttribute('opened');
                    }
                }
            }
        }

        window.customElements.define(StlmNavbar.is, StlmNavbar);
    </script>
</dom-module>