import React from 'react';
import { useSelector } from 'react-redux';

import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';

import "./location.css"

export default () => {
    const config = useSelector((state) => state.hud.config);
    const isShowing = useSelector((state) => state.location.showing);
    const location = useSelector((state) => state.location.location);
    const isBlindfolded = useSelector((state) => state.app.blindfolded);

    if (!isShowing || isBlindfolded) return null;

    return (
        <div
            className='mainContainer' 
            // style={{
                //background: process.env.NODE_ENV == 'production' && config.hideCompassBg ? "transparent" : "yellow",
                // posiition: "absolute",
                // top: 0,
                // width: "100%",
                // height: "5%", 
                // overflow: "hidden",
                // display: "flex",
                // justifyContent: "center",
                // alignItems: "center",
                // boxSizing: "border-box",
                // padding: "2vh",
                // marginTop: "2.5vh",
            // }}
        >
            <div
                className='locationHolder'
                // style={{
                //     backgroundColor: "rgba(0, 0, 0, 0.75)",
                //     width: "auto",
                //     height: "100%",
                //     display: "flex",
                //     justifyContent: "flex-start",
                //     alignItems: "center",
                //     verticalAlign: "middle",
                //     boxSizing: "border-box",
                //     padding: "2vh",
                //     gap: "2vh",
                //     overflow: "hidden",
                //     borderRadius: "1vh",
                //     fontWeight: 600,
                //     fontSize: "1.75vh",
                //     wordSpacing: 2,
                //     letterSpacing: 1,
                //     alignContent: "center",
                //     textAlign: "center",
                // }}
            >
                <div
                    className='locationBlock'
                    // style={{
                    //     display: "flex",
                    //     justifyContent: "center",
                    //     alignItems: "center",
                    //     gap: "1vh",
                    //     textAlign: "center",
                    //     verticalAlign: "middle",
                    // }}
                >
                    <FontAwesomeIcon
                        className='faIcon'
                        // style={{
                            // height: "2.5vh",
                            // width: "auto",
                            // backgroundColor: "orange",
                            // color: "#1e90ff",
                        // }}
                        icon={["far", "compass"]}
                    />

                    {location.direction}
                </div>

                <FontAwesomeIcon
                    className='faIcon'
                    // style={{
                        // height: "2.5vh",
                        // width: "auto",
                        // backgroundColor: "orange",
                        // color: "#1e90ff",
                    // }}
                    icon={["far", "pipe"]}
                />

                <div
                    className='locationBlock'
                    // style={{
                    //     display: "flex",
                    //     justifyContent: "center",
                    //     alignItems: "center",
                    //     gap: "1vh",
                    //     textAlign: "center",
                    //     verticalAlign: "middle",
                    // }}
                >
                    <FontAwesomeIcon
                        className='faIcon'
                        // style={{
                        //     height: "2.5vh",
                        //     width: "auto",
                        //     //backgroundColor: "orange",
                        //     color: "#1e90ff",
                        // }}
                        icon={["far", "location-dot"]}
                    />

                    {location.main}

                    {location.cross && (
                        <>
                            {/* <FontAwesomeIcon
                                className='faIcon'
                                // style={{
                                    // height: "2.5vh",
                                    // width: "auto",
                                    // backgroundColor: "orange",
                                    // color: "#1e90ff",
                                // }}
                                icon={["fas", "xmark"]}
                            /> */}
                            <div>
                                x
                            </div>

                            {location.cross}
                        </>
                    )}
                </div>

                <FontAwesomeIcon
                    className='faIcon'
                    // style={{
                        // height: "2.5vh",
                        // width: "auto",
                        // backgroundColor: "orange",
                        // color: "#1e90ff",
                    // }}
                    icon={["far", "pipe"]}
                />

                <div
                    className='locationBlock'
                    // style={{
                    //     display: "flex",
                    //     justifyContent: "center",
                    //     alignItems: "center",
                    //     gap: "1vh",
                    //     textAlign: "center",
                    //     verticalAlign: "middle",
                    // }}
                >
                    <FontAwesomeIcon
                        className='faIcon'
                        // style={{
                            // height: "2.5vh",
                            // width: "auto",
                            // backgroundColor: "orange",
                            // color: "#1e90ff",
                        // }}
                        icon={["far", "map"]}
                    />

                    {location.area}
                </div>
            </div>
        </div>
    );
};
